Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSLTRlc>; Fri, 20 Dec 2002 12:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSLTRlc>; Fri, 20 Dec 2002 12:41:32 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:48348 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S263215AbSLTRlb>; Fri, 20 Dec 2002 12:41:31 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: DECpc XL 590 -> bios won't set up IRQ's and Linux neither
Date: Fri, 20 Dec 2002 18:49:32 +0100
Message-ID: <00a201c2a850$285a93f0$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a DECpc XL 590, it's an oldy P90.
When it boots up with Linux, I get the following error:
PCI: PCI BIOS revision 2.00 entry at 0xf0100, last bus=0
PCI: Using configuration type 2
PCI: Probing PCI hardware
PCI: fixing NCR 53C810 class code for 00:01.0
PCI: Error 81 when fetching IRQ routing table.  <------------
None of the PCI-devices get an IRQ assigned:
00:07.0 USB Controller: OPTi Inc. 82C861 (rev 10) (prog-if 10 [OHCI])
        Subsystem: OPTi Inc. 82C861
        Flags: medium devsel
        Memory at 10000000 (32-bit, non-prefetchable) [size=4K]

00:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
        Subsystem: Unknown device 3083:0035
        Flags: medium devsel
        Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [40] Power Management version 2
<etc.>

I tried booting with pci=biosirq, to no avail.
Kernel is 2.4.20.
Is this a non-fixable bug in the bios? Bug in the kernel? Anything?

Thank you.
Folkert
