Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318585AbSHAC1g>; Wed, 31 Jul 2002 22:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318587AbSHAC1g>; Wed, 31 Jul 2002 22:27:36 -0400
Received: from ns0.tateyama.or.jp ([210.128.170.1]:45578 "HELO
	ns0.tateyama.or.jp") by vger.kernel.org with SMTP
	id <S318585AbSHAC1f> convert rfc822-to-8bit; Wed, 31 Jul 2002 22:27:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Gabor Kerenyi <wom@tateyama.hu>
To: linux-kernel@vger.kernel.org
Subject: Tulip driver using DEC 2114x
Date: Thu, 1 Aug 2002 11:36:47 +0900
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208011133.52938.wom@tateyama.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I can't get the tulip driver work. I have a 10/100 ethernet controller on the 
motherboard connected to a 10Mbs network.
I get a warning during boot time:

kernel: Linux Tulip driver version 0.9.15-pre9 (Nov 6, 2001)
kernel: PCI: Found IRQ 11 for device 00:0d.0
kernel: tulip0:  EEPROM default media type Autosense
kernel: tulip0:  Index #0 - Media MII (#11) described by a 21141MII PHY (3)
kernel: tulip0: ***WARNING***: No MII transceiver found!
kernel: eth0: Digital DS21143 Tulip rev 65 at 0x1000, 00:A0:B6:00:57:4C, IRQ11

lspci:

00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] 
(rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06)
00:07.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B ACPI 
(rev 10)
00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 
(rev 41)
00:11.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
01:00.0 VGA compatible controller: S3 Inc. Trio 64 3D (rev 01)
02:0b.0 Class ffff: Unknown device 15c7:0349 (rev 01)

00:0d.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/3
	Flags: bus master, medium devsel, latency 64, IRQ 11
	I/O ports at 1000 [size=128]
	Memory at f4000000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=256K]

I tried with 2.5.9 and 2.4.18 but the result is the same. It can be loaded
but ifconfig shows that the error field changes only.

The card works on WinNT.

Do I need some magic tricks to get this card work?

Thanks,

Gabor
