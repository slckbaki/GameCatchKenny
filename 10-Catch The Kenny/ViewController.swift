//
//  ViewController.swift
//  10-Catch The Kenny
//
//  Created by Selcuk Baki on 18/8/21.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyArray = [UIImageView]()
    var hideTimer = Timer()
    var highScore = 0
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var kenny1Image: UIImageView!
    @IBOutlet weak var kenny2Image: UIImageView!
    @IBOutlet weak var kenny3Image: UIImageView!
    @IBOutlet weak var kenny4Image: UIImageView!
    @IBOutlet weak var kenny5Image: UIImageView!
    @IBOutlet weak var kenny6Image: UIImageView!
    @IBOutlet weak var kenny7Image: UIImageView!
    @IBOutlet weak var kenny8Image: UIImageView!
    @IBOutlet weak var kenny9Image: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Highscore Check
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighScore == nil {
            highScore = 0
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            highScoreLabel.text = "Highscore: \(highScore)"
        }
        
        scoreLabel.text = "Score: \(score)"
        kenny1Image.isUserInteractionEnabled = true
        kenny2Image.isUserInteractionEnabled = true
        kenny3Image.isUserInteractionEnabled = true
        kenny4Image.isUserInteractionEnabled = true
        kenny5Image.isUserInteractionEnabled = true
        kenny6Image.isUserInteractionEnabled = true
        kenny7Image.isUserInteractionEnabled = true
        kenny8Image.isUserInteractionEnabled = true
        kenny9Image.isUserInteractionEnabled = true

        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        kenny1Image.addGestureRecognizer(recognizer1)
        kenny2Image.addGestureRecognizer(recognizer2)
        kenny3Image.addGestureRecognizer(recognizer3)
        kenny4Image.addGestureRecognizer(recognizer4)
        kenny5Image.addGestureRecognizer(recognizer5)
        kenny6Image.addGestureRecognizer(recognizer6)
        kenny7Image.addGestureRecognizer(recognizer7)
        kenny8Image.addGestureRecognizer(recognizer8)
        kenny9Image.addGestureRecognizer(recognizer9)
        
        kennyArray = [kenny1Image, kenny2Image,kenny3Image,kenny4Image,kenny5Image,kenny6Image,kenny7Image,kenny8Image,kenny9Image]
        
        
        
        counter = 10
        timeLabel.text = "Time : \(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
        
    }
    
    
    @objc func hideKenny(){
        for kenny in kennyArray{
            kenny.isHidden = true
        }
        let random = Int( arc4random_uniform(UInt32(kennyArray.count-1)))
         kennyArray[random].isHidden = false
    }
    
    
    @objc func countDown(){
        counter -= 1
        timeLabel.text = "Time: \(counter)"
        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()
            timeLabel.text = "Time Is Up"
            
            for kenny in kennyArray{
                kenny.isHidden = true
            }
            
            //HIGHSCORE
            if self.score > self.highScore {
                self.highScore = self.score
                highScoreLabel.text = "Highscore : \(self.highScore)"
                UserDefaults.standard.set(self.highScore, forKey: "highscore")
            }
            
            
            
            //ALERTS
            let alert = UIAlertController(title: "Time Is Over", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            let replay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
                //replay function
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = String(self.counter)
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countDown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
                
            }
                alert.addAction(replay)
                alert.addAction(noButton)
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func increaseScore(){
        
        score += 1
        scoreLabel.text = "Score: \(score)"
        
    }
    
    


}

