Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268076AbTBWJMy>; Sun, 23 Feb 2003 04:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268078AbTBWJMy>; Sun, 23 Feb 2003 04:12:54 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:37760 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S268076AbTBWJMw>; Sun, 23 Feb 2003 04:12:52 -0500
Date: Sun, 23 Feb 2003 18:21:16 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] PC-9800 subarch. support for 2.5.62-AC1 (0/21) summary
Message-ID: <20030223092116.GA1324@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is additional patch to support NEC PC-9800 subarchitecture
against 2.5.62-ac1.

You can get whole patchset from URL below.
http://downloads.sourceforge.jp/linux98/2469/linux98-2.5.62-ac1.patch.tar.bz2
Comments and test reports are wellcome.

Description:
 o alsa-pc98.patch (1/21)
   ALSA sound drivers for PC98.
 o apm.patch (2/21)
   APM support for PC98. Including PC98's BIOS bug fix.
 o console.patch (3/21)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (4/21)
   Small core patches for PC98.
 o dma.patch (5/21)
   DMA support for PC98.
 o fs.patch (6/21)
   FAT fs and partition table support for PC98.
 o ide.patch (7/21)
   PC98 standard IDE I/F support.
 o kanji.patch (8/21)
   japanese kanji character support for PC98 console.
 o kconfig.patch (9/21)
   Add selection CONFIG_X86_PC9800.
 o network_card.patch (10/21)
   C-bus(PC98's legacy bus like ISA) network cards support.
 o parport.patch (11/21)
   Parallel port support.
 o pci.patch (12/21)
   Small changes for PCI support.
 o pcmcia.patch (13/21)
   Small change for PCMCIA (16bits) support.
 o pnp.patch (14/21)
   Small change for Legacy bus PNP support.
 o rtc.patch (15/21)
   Support RTC for PC98, using mach-* scheme.
 o scsi.patch (16/21)
   SCSI host adapter support.
 o serial.patch (17/21)
   Serial port support for PC98.
 o setup.patch (18/21)
   Support difference of IO port/memory address, using mach-* scheme.
 o smp.patch (19/21)
   SMP support for PC98.
 o timer.patch (20/21)
   Support difference of timer, using mach-* scheme.
 o traps.patch (21/21)
   Support difference of NMI handling, using mach-* scheme.

Thanks,
Osamu Tomita <tomita@cinet.co.jp>

