Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275265AbRIZP0B>; Wed, 26 Sep 2001 11:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275266AbRIZPZv>; Wed, 26 Sep 2001 11:25:51 -0400
Received: from [213.236.192.200] ([213.236.192.200]:63420 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S275265AbRIZPZm>; Wed, 26 Sep 2001 11:25:42 -0400
Message-ID: <009b01c1469f$cc704a20$d2c0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Asus CUV266-D problems
Date: Wed, 26 Sep 2001 17:27:46 +0200
Organization: CircleStorm Productions
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having big problems with booting on this motherboard.

It is a dual motherboard with 2x Intel P3 866Mhz cpus
Asus CUV 266-D  Bios rev. 1003

I have tried to boot with the following kernels:
2.4.0 (SuSE 7.1 Install CD)
2.4.4? (SuSE 7.2 Install CD)
2.4.10 Custom compiled with SMP, but no extra ACPI or APM

2.4.0 boots and works for a while, but installation always fails..
It just stops, and never gives any error messages.

2.4.4 boots and works for a while, but installation always fails..
It most often stops, but some times it complains about some HDD
error (too fast for me to see what it actually says) then reboots.

2.4.10 boots, but only with MPS 1.1, and most of the bios in safety mode.
When it gets to checking the HDD it fails and mounts it read-only.

I can see ACPI errors occuring while booting, but they run along too fast
for me to fine-read.. (any way to pause/delay it?)
Something about unexpected or unknown ACPI-IO *i think*

I have tried to change the HDD with another one, and have confirmed
that both are working in another comp. (Western Digital WD200)

I'll type _some_ of what lspci outputs, please forgive any spellings and
shorts:
00:00.0 Host bridge: VIA Tech, Inc. VT8633 [Apollo Pro266] (rev 01)
            subsystem: Asustek Computer, Inc.: Unknown device 8064
            Flags: bus master, medium devsel, latency 0
            Memory at fe000000 (32-bit, prefetch) [size=8M]
            Capabilities: [a0] AGP version 2.0
            Capabilities: [c0] Power Management ver. 2

00:01.0 PCI bridge: VIA Tech, Inc. VT8633 [Apollo Pro266 AGP] (prog-if 00
[normal decode])
            Flags: bus master, 66Mhz, medium devsel, latency 0
            Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
            Memory behind bridge: f6000000-f7efffff
            Prefetchable memory behind bridge: fbf00000-fdffffff
            Capabilities: [80] Power management ver. 2

00:11.0 ISA bridge: VIA Tech, Inc. VT8233 PCI to ISA Bridge
            subsystem: Asustek Computer, Inc.: Unknown device 8052
            Flags: bus master, stepping, medium devsel, latency 0
            Capabilities: [c0] Power Management ver. 2

00:11.1 IDE interface: VIA Tech, Inc. Bus Master IDE (rev 06)
            Flags: bus master, stepping, medium devsel, latency 32
            I/O ports at a800 [size=16]
            Capabilities: [c0] Power Management ver. 2

In addition these are listed, please ask me if you need more details:
00:0e.0 PCI bridge: Digital Equip. Corp. DECchip 21152 (rev 03)
00:10.0 PCI bridge: Digital Equip. Corp. DECchip 21152 (rev 03)
01:00.0 VGA compat. contr.: nVidia Corp. Vanta [NV6] (rev 15)
02:04.0 Ethernet Controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
02:05.0 Ethernet Controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
03:04.0 Ethernet Controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)
03:05.0 Ethernet Controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 05)

There are two Intel Dual server NIC's in the box..  meaning each card has
1x DEC21152, and 2x Intel82557 on them.

If you need any other info, please let me know.

Please give me feedback on what this might be, and how this can be solved.


- Hans K. Rosbach aka Dead2



