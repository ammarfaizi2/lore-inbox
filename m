Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270759AbTHJXOS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 19:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270760AbTHJXOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 19:14:17 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:28589 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S270759AbTHJXOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 19:14:16 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 vs acpi
Date: Sun, 10 Aug 2003 19:14:15 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101914.15673.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.63.55] at Sun, 10 Aug 2003 18:14:15 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

I turned off the acpi stuffs now and it boots, including with the 
advansys driver built in.  Someone asked me to check 
/proc/interrupts, which gave me a clue that I should enable an ESCD 
update in the bios.  This moved some interrupts around and it seems 
all is well, I'm running it, with X, on my gforce2 card right now.

However, this has the side effect of disabling a 'shutdown -h now' 
which only reboots the machine instead of doing the shutdown.

Also, my oss-install for 3.9.7k fails so I have no sound, not even a 
console beep.  On going to www.opensound.com, I do not find a 2.6.x 
compatible version.

Where is the info to make alsa work (it didn't work with this chipset 
a year ago) now?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

