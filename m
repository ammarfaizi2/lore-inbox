Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261852AbREMTiM>; Sun, 13 May 2001 15:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261854AbREMTiC>; Sun, 13 May 2001 15:38:02 -0400
Received: from ghost.btnet.cz ([62.80.85.74]:22025 "HELO ghost.btnet.cz")
	by vger.kernel.org with SMTP id <S261852AbREMThr>;
	Sun, 13 May 2001 15:37:47 -0400
Date: Sun, 13 May 2001 21:38:53 +0200
From: clock@ghost.btnet.cz
To: linux-kernel@vger.kernel.org
Subject: Linux TCP impotency
Message-ID: <20010513213853.A5700@ghost.btnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using 2.2.19 I discovered that running two simultaneous scp's (uses up whole
capacity in TCP traffic) on a 115200bps full duplex serial port nullmodem cable
causes the earlier started one to survive and the later to starve. Running bcp
instead of the second (which uses UDP) at 11000 bytes per second caused the
utilization in both directions to go up nearly to 100%.

Is this a normal TCP stack behaviour?

-- 
Karel Kulhavy                     http://atrey.karlin.mff.cuni.cz/~clock
