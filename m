Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280419AbRKKTAG>; Sun, 11 Nov 2001 14:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280435AbRKKS75>; Sun, 11 Nov 2001 13:59:57 -0500
Received: from m223-mp1-cvx1b.man.ntl.com ([62.252.200.223]:11648 "EHLO
	box.penguin.power") by vger.kernel.org with ESMTP
	id <S280387AbRKKS7m>; Sun, 11 Nov 2001 13:59:42 -0500
Date: Sun, 11 Nov 2001 18:59:30 +0000
From: Gavin Baker <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: SiS630 and 5591/5592 AGP
Message-ID: <20011111185930.A2700@box.penguin.power>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My new laptop has this combination and the sis framebuffer driver
mangles the display. The sis X driver produces a nice lavalamp style
pattern that fades to white, the kernel stays alive but the machine
needs a reboot to fix the display in both cases. 

Im guessing the lack of 5591/5592 AGP support is the problem, and I 
was just wondering if anyone is working on this or should i go bug SiS?

Everything else is 100%.

00:00.0 Host bridge: Silicon Integrated Systems [SiS] 630 Host (rev 31)
00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:01.1 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 82)
00:01.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.3 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 07)
00:01.4 Multimedia audio controller: Silicon Integrated Systems [SiS]
SiS PCI Audio Accelerator (rev 02)
00:01.6 Modem: Silicon Integrated Systems [SiS]: Unknown device 7013
(rev a0)
00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:03.0 CardBus bridge: O2 Micro, Inc. OZ6812 Cardbus Controller (rev
05)
01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS]
SiS630 GUI Accelerator+3D (rev 31)

Cheers,
Gavin Baker
