Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUBKWfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 17:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUBKWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 17:35:38 -0500
Received: from moutng.kundenserver.de ([212.227.126.173]:6106 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266216AbUBKWeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 17:34:46 -0500
From: Emmeran Seehuber <rototor@rototor.de>
To: linux-kernel@vger.kernel.org
Subject: PS/2 Mouse does no longer work with kernel 2.6 on a laptop
Date: Wed, 11 Feb 2004 23:44:23 +0000
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X5rKAZdA3khvRgl"
Message-Id: <200402112344.23378.rototor@rototor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:d84d732d8ddd2281dac05c143a411240
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_X5rKAZdA3khvRgl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody!

I'm trying to switch my laptop from kernel 2.4 to kernel 2.6.2. Everything 
seems to work correctly, only my PS/2 mouse doesn't.

My laptop has a touchpad and a PS/2 port. On the PS/2 port I usually attach a 
Logitech trackball. With kernel 2.4 I was able to use touchpad and trackball 
at the same time. With kernel 2.6 the trackball on the PS/2 port seems to be 
recognized, but it doesn`t work :( Neither in X11 nor with gpm on the console 
I get an input from the trackball, i.e. I can`t move the pointer nor click.

The kernel gives me the following information about the found input devices:

i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
input: PS2++ Logitech Mouse on isa0060/serio2
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0

Also in /dev/input exists these devices:

crw-r--r--    1 root     root      13,  63 1970-01-01 00:00 mice
crw-r--r--    1 root     root      13,  32 1970-01-01 00:00 mouse0
crw-r--r--    1 root     root      13,  33 1970-01-01 00:00 mouse1

Other non-PS/2 devices work, e.g. when I attach an USB mouse, that mouse 
works. 

What could be wrong with my configuration?

cu,
  Emmy
P.S.: Please CC me, since I'm not subscribed.

--Boundary-00=_X5rKAZdA3khvRgl
Content-Type: text/plain;
  charset="us-ascii";
  name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.txt"

00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device 0646 (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP
00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device 0962 (rev 14)
00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire Controller
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
00:02.6 Modem: Silicon Integrated Systems [SiS] 56k Winmodem (Smart Link HAMR5600 compatible) (rev a0)
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 PCI Audio Accelerator (rev a0)
00:03.0 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
00:03.1 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
00:03.2 USB Controller: Silicon Integrated Systems [SiS] 7001 (rev 0f)
00:03.3 USB Controller: Silicon Integrated Systems [SiS]: Unknown device 7002
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C (rev 10)
00:0c.0 CardBus bridge: ENE Technology Inc: Unknown device 1410
01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4c66 (rev 01)

--Boundary-00=_X5rKAZdA3khvRgl
Content-Type: application/x-gzip;
  name="kernelconfig.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="kernelconfig.gz"

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
nBrNW4BKMqpT+7Ul/R7h38hdUKu7cwAA

--Boundary-00=_X5rKAZdA3khvRgl--
