Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbTFOMgF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbTFOMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 08:36:05 -0400
Received: from burningchrome.demon.co.uk ([62.49.12.86]:64904 "EHLO
	boole.clues.ltd.uk") by vger.kernel.org with ESMTP id S262175AbTFOMgD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 08:36:03 -0400
Message-Id: <6.0.0.9.0.20030615121539.02b98950@10.119.48.254>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.9 (Beta)
Date: Sun, 15 Jun 2003 12:49:55 +0100
To: linux-kernel@vger.kernel.org
From: "Martin A. Brooks" <martin@hinterlands.org>
Subject: USB and/or keyboard bizarreness
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I recently purchased an Epox 8RDA (nforce2) motherboard.  I'm using 1 gig 
of ddr 266 memory and an athlon 1.3ghz downclocked to 1.1ghz.

At the BIOS screen, the keyboard works just fine when connected via either 
the USB or PS2 port.

When booting 2.4.18, the kernel halts when loading the OHCI driver.
When booting 2.4.20, the system comes up but the keyboard doesn't respond 
when plugged in to the ps2 port, I can't try it with USB.
When booting 2.4.21, kernel panic.

The kernel configuration is essentially the same in all three kernels.

The keyboard works fine in Windows when plugged in via USB. When plugged in 
via the ps2 port, it will occasionally act as though the shift and caps 
lock keys are held down (i.e. only capital letters and punctuation).  This 
can be reset, though, by typing a colon (i.e. pressing shift+; ).

I would like to write this off as a hardware problem (i.e. dodgy keyboard), 
but the kernel panic confuses me. Annoyingly, I won't have a way to get the 
exact kernel configuration until Monday. A screenshot (yes, I know, sorry) 
of the panic can be found here:

http://www.hinterlands.org/kp.jpg

Please CC me on any replies.

Yours, dazed and confused,


Martin A. Brooks
---------------------------------
I/O, I/O, it's off to disk we go,
A bit or byte, to read or write,
I/O, I/O, I/O......  

