Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268233AbRG3Vdr>; Mon, 30 Jul 2001 17:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268272AbRG3Vdi>; Mon, 30 Jul 2001 17:33:38 -0400
Received: from die-macht.oph.RWTH-Aachen.DE ([137.226.147.190]:23390 "EHLO
	die-macht") by vger.kernel.org with ESMTP id <S268139AbRG3VdV>;
	Mon, 30 Jul 2001 17:33:21 -0400
Message-ID: <3B65D2A9.625BF3A4@die-macht.oph.rwth-aachen.de>
Date: Mon, 30 Jul 2001 23:33:29 +0200
From: Stefan Becker <stefan@die-macht.oph.rwth-aachen.de>
Reply-To: stefan@oph.rwth-aachen.de
Organization: OPH Netzwerkgruppe
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133A / athlon / MMX
In-Reply-To: <3B62186E.B89C29E8@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

FWIW,
I have an ASUS A7V133 with a T-Bird 900, running 2.4.7ac3+ext3 with K7
optimization enabled.
It's rock solid.

2.4.6ac5 and previous ran a long time without problems too.

'lspci -vxxx' shows:

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: bus master, medium devsel, latency 0
        Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2
00: 06 11 05 03 06 00 10 a2 03 00 00 06 00 00 00 00
10: 08 00 00 e4 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 42 80
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 17 a4 6b b4 06 28 20 20 88 80 08 08 10 18 20 20
60: 3f ff 55 a0 52 52 52 00 40 7c 86 0f 08 1f 00 00
70: de c0 cc 0c 0e a1 d2 00 01 b4 11 02 00 00 00 09
80: 0f 40 00 00 c0 00 00 00 03 00 e0 1f 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 02 c0 20 00 17 02 00 1f 00 00 00 00 6e 02 14 00
b0: 7f 69 02 c5 32 33 28 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 84 22 00 00 00 00 00 91 06

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [N
ormal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: e0000000-e16fffff
        Prefetchable memory behind bridge: e2f00000-e3ffffff
        Capabilities: [80] Power Management version 2
00: 06 11 05 83 07 00 30 22 00 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 01 00 e0 d0 00 00
20: 00 e0 60 e1 f0 e2 f0 e3 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 08 00
40: cb cd 18 14 27 72 05 83 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 01 00 22 02 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2
00: 06 11 86 06 87 00 10 02 40 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 42 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 00 00 00 00
40: 08 41 00 00 00 80 62 ee 05 01 44 00 00 00 00 f3
50: 0e 06 00 00 00 b0 4a 30 00 04 ff 08 80 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 25 08 40 82 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 09 00 00 00 60 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 41 00 00 00 00 00 00 00 00 00

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
[snipped]

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
[snipped]

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Flags: medium devsel, IRQ 9
        Capabilities: [68] Power Management version 2
00: 06 11 57 30 00 00 90 02 40 00 00 06 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 42 80
30: 00 00 00 00 68 00 00 00 00 00 00 00 00 00 00 00
40: 20 80 49 00 12 10 00 00 01 e4 00 00 48 10 00 00
50: 00 ff ff 04 90 04 00 00 00 ff ff 00 43 10 42 80
60: 00 00 00 00 00 00 00 00 01 00 02 00 00 00 00 00
70: 01 e2 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 01 e8 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 01 00 00 00 40 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:04.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio
Controller (rev 50)
[snipped]

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
[snipped]

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
[snipped]

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
[snipped]

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
[snipped]

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200 AGP
(rev 03) (prog-if 00 [VGA])
[snipped]


Stefan

-- 
Jul 10 00:43:47 unknown kernel: Out of Memory: Killed process 24829
(eatmem).
