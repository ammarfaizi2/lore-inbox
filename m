Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132847AbRDDPlb>; Wed, 4 Apr 2001 11:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132844AbRDDPlV>; Wed, 4 Apr 2001 11:41:21 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:4322 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S132843AbRDDPlF>; Wed, 4 Apr 2001 11:41:05 -0400
From: Ford Prefect <ford_prefect@technologist.com>
Date: Wed, 4 Apr 2001 17:34:45 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: sscape.c modification
MIME-Version: 1.0
Message-Id: <01040417302700.00664@magrathea>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello!
i have been using a spea mediafx soundcard for quite some time now but 
recently faced a problem configuring the card. the card has a mic/line input 
that can be switched between mic mode (mono, 20db preamplification) and line 
mode (stereo, no preamp). since i recently aquired a tv-card i wanted to use 
the mic/line input for the tv-card. unfortunately there is no option for 
switching modes. i do not know if other cards using the ensoniq soundscape 
chipset have this feature and if this is of interest for a greater audience, 
but i thought i would rather like having a modified sscape kernel (or at 
least a switch applicable when using sscape as a module).

since i did not find any information about this problem on the web i started
reverse-engineering the dos ssinit.exe program of my own. i think i managed 
to find out the required values and registers program the soundcard to either 
mode and it works fine for me with a slightly modified sscape.c. but i also 
know that the way i modified sscape.c would not satisfy all users since the 
module is for both the old-fashioned sscape cards and the newer plug-and-play 
cards that maybe should not be programmed that way.

the things i would like to know
1) is there anybody else using/having a soundscape card that has the 
switchable input and who would test my modification
2) would it be worth modifying sscape.c so that other people might set their
cards to whatever they would prefer (i.e. do you think other there might be 
others using this card anyway)
3) how would/should i change the driver (only adding an optional switch when 
used as a module or other suggestions)
4) who should i talk to about changing or maybe submitting a modified sscape 
module

i was unable to find out if this module was actively maintained so i wrote to 
the list.

by the way, i am using the suse-modified kernel 2.2.16

greets

  seb

