Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262387AbTCIDms>; Sat, 8 Mar 2003 22:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262388AbTCIDms>; Sat, 8 Mar 2003 22:42:48 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:35968 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S262387AbTCIDmr>; Sat, 8 Mar 2003 22:42:47 -0500
Date: Sun, 9 Mar 2003 12:52:45 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>
Subject: [PATCH] PC-9800 subarch. support for 2.5.64-ac3
Message-ID: <20030309035245.GA1231@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.64-ac3.

You can download archived patchset from URL bellow.
http://downloads.sourceforge.jp/linux98/2575/linux98-2.5.64-ac3.patch.tar.bz2
Patchset against vanilla 2.5.64 is also available.
http://downloads.sourceforge.jp/linux98/2574/linux98-2.5.64.patch.tar.bz2

Comments and test reports are wellcome.

Description:
 o boot98-update.patch (1/20)
   Updates arch/i386/boot98/* in 2.5.64-ac3.
 o char_device-update.patch (2/20)
   Updates drivers/char/* in 2.5.64-ac3.
 o console.patch (3/20)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (4/20)
   Small patches for PC98 support core.
 o core-update.patch (5/20)
   Updates PC98 core files in 2.5.64-ac3.
 o dma.patch (6/20)
   DMA support for PC98.
 o ide.patch (7/20)
   PC98 standard IDE I/F support.
 o input-update.patch (8/20)
   Updates drivers/input/* in 2.5.64-ac3.
 o kanji.patch (9/20)
   japanese kanji character support for PC98 console.
 o kconfig.patch (10/20)
   Add selection for CONFIG_X86_PC9800.
 o network_card.patch (11/20)
   C-bus(PC98's legacy bus like ISA) network cards support.
 o parport.patch (12/20)
   Parallel port support.
 o pci.patch (13/20)
   Small changes for PCI support.
 o pcmcia.patch (14/20)
   Small change for PCMCIA (16bits) support.
 o rtc.patch (15/20)
   Support RTC for PC98, using mach-* scheme.
 o scsi.patch (16/20)
   SCSI host adapter support.
 o serial.patch (17/20)
   Serial port support for PC98.
 o setup.patch (18/20)
   Support difference of IO port/memory address, using mach-* scheme.
 o smp.patch (19/20)
   SMP support for PC98.
 o timer.patch (20/20)
   Support difference of timer, using mach-* scheme.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

