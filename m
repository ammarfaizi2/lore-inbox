Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUFQNyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUFQNyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 09:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUFQNyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 09:54:46 -0400
Received: from vsmtp14.tin.it ([212.216.176.118]:64924 "EHLO vsmtp14.tin.it")
	by vger.kernel.org with ESMTP id S266496AbUFQNy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 09:54:29 -0400
Message-ID: <40D1A282.7010006@tin.it>
Date: Thu, 17 Jun 2004 15:54:10 +0200
From: HayArms <voloterreno@tin.it>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [2.6.7] AGP KT600 identified as CLE266
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've compiled vanilla kernel 2.6.7 just today, and I've noticed that my 
KT600 AGP chipset is identified ad CLE266 :

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: AGP aperture is 256M @ 0xc0000000

is this a bug or is normal?

Bye

Marcello


lspci -vx :

melchior@melchior:~$ lspci -vx
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 
AGP] Host Bridge (rev 80)
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, 66MHz, medium devsel, latency 8
        Memory at c0000000 (32-bit, prefetchable)
        Capabilities: <available only to root>
00: 06 11 89 31 06 00 30 22 80 00 00 06 00 08 00 00
10: 08 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge 
(prog-if 00 [Normal decode])
        Flags: bus master, 66MHz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d0000000-d7ffffff
        Prefetchable memory behind bridge: d8000000-dfffffff
        Capabilities: <available only to root>
00: 06 11 98 b1 07 01 30 02 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 f0 00 20 22
20: 00 d0 f0 d7 00 d8 f0 df 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 0c 00

0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA 
RAID Controller (rev 80)
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at b000
        I/O ports at b400 [size=4]
        I/O ports at b800 [size=8]
        I/O ports at bc00 [size=4]
        I/O ports at c000 [size=16]
        I/O ports at c400 [size=256]
        Capabilities: <available only to root>
00: 06 11 49 31 07 00 90 02 80 00 04 01 00 20 80 00
10: 01 b0 00 00 01 b4 00 00 01 b8 00 00 01 bc 00 00
20: 01 c0 00 00 01 c4 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0b 02 00 00

0000:00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at c800 [size=16]
        Capabilities: <available only to root>
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c8 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 00 00

0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at cc00 [size=32]
        Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 cc 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 01 00 00

0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at d000 [size=32]
        Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d0 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 01 00 00

0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at d400 [size=32]
        Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d4 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 02 00 00

0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 81) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 201
        I/O ports at d800 [size=32]
        Capabilities: <available only to root>
00: 06 11 38 30 07 00 10 02 81 00 03 0c 08 20 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 d8 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 80 00 00 00 00 00 00 00 09 02 00 00

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge 
[K8T800 South]        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: <available only to root>
00: 06 11 27 32 87 00 10 02 00 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: medium devsel, IRQ 217
        I/O ports at dc00
        Capabilities: <available only to root>
00: 06 11 59 30 01 00 10 02 60 00 01 04 00 00 00 00
10: 01 dc 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 c0 00 00 00 00 00 00 00 0c 03 00 00

0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 78)
        Subsystem: ABIT Computer Corp.: Unknown device 1408
        Flags: bus master, medium devsel, latency 32, IRQ 225
        I/O ports at e000
        Memory at e0001000 (32-bit, non-prefetchable) [size=256]
        Capabilities: <available only to root>
00: 06 11 65 30 07 00 10 02 78 00 00 02 08 20 00 00
10: 01 e0 00 00 00 10 00 e0 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 7b 14 08 14
30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 03 08

0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 
[GeForce3 Ti 200] (rev a3) (prog-if 00 [VGA])
        Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 169
        Memory at d0000000 (32-bit, non-prefetchable)
        Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Memory at dc000000 (32-bit, prefetchable) [size=512K]
        Capabilities: <available only to root>
00: de 10 01 02 07 00 b0 02 a3 00 00 03 00 20 00 00
10: 00 00 00 d0 08 00 00 d8 08 00 00 dc 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 60 00 00 00 00 00 00 00 0a 01 05 01



