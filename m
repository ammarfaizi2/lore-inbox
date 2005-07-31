Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263207AbVGaLRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263207AbVGaLRJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 07:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbVGaLRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 07:17:06 -0400
Received: from [195.141.97.121] ([195.141.97.121]:26643 "EHLO propic.ayni.com")
	by vger.kernel.org with ESMTP id S263207AbVGaLOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 07:14:52 -0400
Message-ID: <42ECB294.7040608@ayni.com>
Date: Sun, 31 Jul 2005 13:14:28 +0200
From: apache <apache@ayni.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: How come that in kernel 2.6.11 a dvd is readable, but not in kernel
 2.6.12?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi every,
HW: Dell Inspirion 8100
root@rosetta ~> lspci
00:00.0 Host bridge: Intel Corporation 82815 815 Chipset Host Bridge and 
Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 82815 815 Chipset AGP Bridge (rev 04)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 03)
00:1f.0 ISA bridge: Intel Corporation 82801BAM ISA Bridge (LPC) (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801BAM IDE U100 (rev 03)
00:1f.2 USB Controller: Intel Corporation 82801BA/BAM USB (Hub #1) (rev 03)
01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
M7 LW [Radeon Mobility 7500]
02:03.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i 
PCI Audio Accelerator (rev 10)
02:06.0 Ethernet controller: 3Com Corporation 3c556 Hurricane CardBus 
[Cyclone] (rev 10)
02:06.1 Communication controller: 3Com Corporation Mini PCI 56k Winmodem 
(rev 10)
02:0f.0 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.1 CardBus bridge: Texas Instruments PCI4451 PC card Cardbus Controller
02:0f.2 FireWire (IEEE 1394): Texas Instruments PCI4451 IEEE-1394 Controller
root@rosetta ~>

root@rosetta ~> uname -a
Linux rosetta.ayni.com 2.6.11-1.27_FC3_cubbi3_swsusp2 #1 Thu Jun 2 
15:49:23 CEST 2005 i686 i686 i386 GNU/Linux
root@rosetta ~>



I write a DVD on another Linux machine,

tico:~ # lspci
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 
661FX/M661FX/M661MX Host (rev 11)
0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS]: Unknown 
device 0003
0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS] SiS964 [MuTIOL 
Media IO] (rev 36)
0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] 
(rev 01)
0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems 
[SiS] Sound Controller (rev a0)
0000:00:03.0 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.1 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0 
Controller (rev 0f)
0000:00:03.3 USB Controller: Silicon Integrated Systems [SiS] USB 2.0 
Controller
0000:00:0b.0 Communication controller: Agere Systems (former Lucent 
Microelectronics) V.92 56K WinModem (rev 03)
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:00:0e.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 
661FX/M661FX/M661MX/741/M741/760/M760 PCI/AGP
tico:~ #
tico:~ # uname -a
Linux tico 2.6.8-24.11-default #1 Fri Jan 14 13:01:26 UTC 2005 i686 i686 
i386 GNU/Linux
tico:~ #

but when I read that DVD on the original machine, the system is stuck, 
no CTRL-ALT-DEL accepted, no keyboard input, no mouse, no CTRL-ALT-BKSP, 
all blocked.
when I read the same DVD on the second machine, where I wrote it, 
everything is fine.
when I boot the original machine with kernel-2.6.11 everything is fine 
as well.

Fact: I can write a DVD on a machine with kernel-2.6.11, but I cannot 
read that DVD in a machine with kernel-2.6.12, even worse: the system is 
stuck.

please explain

suomi

