Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264825AbRGCQSo>; Tue, 3 Jul 2001 12:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264816AbRGCQSe>; Tue, 3 Jul 2001 12:18:34 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:17682 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S264825AbRGCQSR>; Tue, 3 Jul 2001 12:18:17 -0400
X-Apparently-From: <bitwize.geo@yahoo.com>
Date: Tue, 3 Jul 2001 12:01:41 -0400
From: Jeff Read <bitwize.geo@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Fun with Athlon, VIA KX133, and kernel 2.4.x
Message-ID: <20010703120141.A366@gas-o.stevens-tech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My system has a Procomp BVK1A mainboard sporting one of those dreaded VIA KX133 chipsets. I have been a virtual lurker, monitoring the archives, and have heard plenty of horror stories about this chipset, but let me make clear that this board was rock-solid for the better part of a year. It would go for weeks without a power-off or reboot. People would look at me funny, and ask, "Doesn't your computer *crash*?" (Of course not; it runs Linux!)

Then, a couple of months ago, I installed 2.4.4. And that, as Stevie B. once said, was where the heartache began.

Every time I use X, given sufficient time (between 15 minutes and 24 hours), the system would freeze. Solid. I haven't tried the Magic SysRq key, but heck, my CapsLock won't even go on and off. Usually it takes a while but the problem seems to be exacerbated by heavy-load, graphics-intensive applications (GIMP and Mozilla come to mind). Console mode seems to run okay, but in the Real World sometimes a GUI is necessary.

That's not the half of it. Sometimes, Windows freezes in identical fashion. I've even experienced it occasionally under NetBSD, but that usually takes quite a long while. I've tried 2.4.4, 2.4.5, several AC patches to 2.4.5, then I went back and tried 2.4.1. I've compiled it for an Athlon, a PII, a Pentium, and a 486. I suspected the AGPGART and DRI drivers and so I unloaded those as well. I'm typing this message to you under kernel 2.2.19. I am still experiencing freezes. Remember, this box was incredibly stable before 2.4.4 and I really don't want to give up this mainboard and CPU; it's got some nice things (like 2 serial ports!) that are hard to find anymore.

The CPU is not overclocked and I have ruled out cooling problems (the fans hum nicely at top speed). I was wondering if anyone knew what's going on, and if there's some patch I need to apply. Did I tickle some sort of schroedinbug in the chipset that was kind of hiding there, waiting to make things fail? If anyone has any answers, please CC me personally. Thanks for all your time and patience.
-- 
----------------------------------------------------------------------
Jeff Read <bitwize@geocities.com>
Unix Code Artist, Anime Fan, Really Cool Guy

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

