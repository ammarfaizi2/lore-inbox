Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271210AbTG2BOX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271211AbTG2BOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 21:14:23 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:61096 "HELO
	trinity-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S271210AbTG2BOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 21:14:22 -0400
X-Analyze: Velop Mail Shield v0.0.3
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 test report
Message-Id: <20030729011407.4B6A126DC1@macp.eti.br>
Date: Mon, 28 Jul 2003 22:14:07 -0300 (BRT)
From: root@macp.eti.br (root)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that 2.6.0-test2 is out, here's my -test1 report.
The only issue I found is with fbcon. I have a Matrox G550, a every now and then
the screen will get garbled on scroll. I can switch to another vc and back to
clear up the mess, but it's pretty useless when trying to track a make bzImage,
as the screen will get messed up again and again and again, no matter
how many times you clear it up. So I finally gave up on fbcon, and now I'm using
the VGA console, leaving all graphical stuff to X. Aside from that, I can play
quake, run MPlayer under XVideo, mozilla, KMail, gcc, wine, star office, no
other problems so far.

Have already upgraded the kernel to 2.6.0-test2, after 24 hrs (this is my main
desktop), everything is fine.

Specs:
Athlon MP 1.8 GHz - 512 MB DDR PC 2100
Asus A7S333 Motherboard
2 IDE UDMA-100 HD's
1 DVD  Reader
1 CD-RW Sony writer

lspci output:
00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0745 (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS85C503/5513 (LPC Bridge)
00:02.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0)
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
00:08.0 Communication controller: Lucent Microelectronics LT WinModem (rev 02)
00:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (rev 11)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G550 AGP (rev 01)

Great job.
