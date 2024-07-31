//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var lblMessgae: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTimes = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var secondsCompleted = 0
    var totalTime = 0
    
    var player: AVAudioPlayer!
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        progressBar.progress = 0.0
        timer.invalidate()
        if (player != nil && player.isPlaying) {
            player.stop()
        }
        
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        secondsCompleted = 0
        lblMessgae.text = hardness

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer () {
        if (secondsCompleted < totalTime) {
            secondsCompleted += 1
            progressBar.progress = Float(secondsCompleted) / Float(totalTime)
        }
        else {
            timer.invalidate()
            lblMessgae.text = "Done!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
