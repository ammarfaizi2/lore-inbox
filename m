Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282951AbRLDBLZ>; Mon, 3 Dec 2001 20:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275552AbRLDBGH>; Mon, 3 Dec 2001 20:06:07 -0500
Received: from ftpbox.mot.com ([129.188.136.101]:34297 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id <S278450AbRLDBFu>;
	Mon, 3 Dec 2001 20:05:50 -0500
Date: Mon, 3 Dec 2001 19:05:49 -0600 (CST)
From: Patrick E Kane <kane@urbana.css.mot.com>
Message-Id: <200112040105.TAA16617@wrangler.urbana.css.mot.com>
To: linux-kernel@vger.kernel.org
Subject: Bogus BogoMIPS on ThinkPad?  [Entertainment for Linus]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When my ThinkPad 600E boots Linux says that it has a 75 MHz CPU,
but my BIOS tells me it has a 300 MHz CPU -- whats the deal?

  Linux version 2.4.9-13 (bhcompile@stripples.devel.redhat.com)
    (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-98)) #1
    Tue Oct 30 20:11:04 EST 2001
 ...
 Initializing CPU#0
 Detected 75.431 MHz processor.
 Console: colour VGA+ 80x25
 Calibrating delay loop... 169.98 BogoMIPS
 ...

My guess is that the TP is doing me a favour by running the
CPU at a reduced speed to save my battery.  I'm running 
with my charge plugged in so I'd like to have my BogoMIPS back.


The BogoMIPS HOWTO says:

  The reasons (there are two) it is printed during boot-up is that 
   a) it is slightly useful for debugging and for checking that the
      computers caches and turbo button work, and 
   b) Linus loves to chuckle when he sees confused people on the news.

Confused,

PEK
---
