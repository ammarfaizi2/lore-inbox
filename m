Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261694AbTCaPzL>; Mon, 31 Mar 2003 10:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbTCaPzL>; Mon, 31 Mar 2003 10:55:11 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:24960 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261694AbTCaPzK>; Mon, 31 Mar 2003 10:55:10 -0500
Date: Tue, 1 Apr 2003 01:04:58 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET] PC-9800 sub architecture support for 2.5.66-bk6
Message-ID: <20030331160458.GA1065@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the patchset to support NEC PC-9800 subarchitecture
against 2.5.66-bk6.

Archived all patches can be downloaded from following URL.
http://downloads.sourceforge.jp/linux98/2931/linux98-2.5.66-bk6.patch.tar.bz2
Comments and test reports are wellcome.

Description:
 Update for merged files.
 o 98kbd-update.patch (1/3)
   Update keyboard driver for PC-98.
 o alsa-pc98-update.patch (2/3)
   Update ALSA sound driver for PC-98.
 o fs-update.patch (3/3)
   Fix compilation when configure PC98 partition and BSD disk label.

 Additional patches
 o apm.patch (1/22)
   APM support for PC98. Including PC98's BIOS bug fix.
 o arch.patch (2/22)
   Config and Make for PC98.
 o char_device.patch (3/22)
   PC98 specific character device driver support.
 o console.patch (4/22)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (5/22)
   Small patches for PC98 support core.
 o core.patch (6/22)
   Patches for PC98 support core.
 o dma.patch (7/22)
   DMA support for PC98.
 o floppy98-1.patch (8/22)
   PC98 standard floppy disk drives support. 1 of 2.
 o floppy98-2.patch (9/22)
   PC98 standard floppy disk drives support. 2 of 2.
 o ide.patch (10/22)
   PC98 standard IDE I/F support.
 o kanji.patch (11/22)
   japanese kanji character support for PC98 console.
 o parport.patch (12/22)
   Parallel port support.
 o pci.patch (13/22)
   Small changes for PCI support.
 o pcmcia.patch (14/22)
   Small change for PCMCIA (16bits) support.
 o rtc.patch (15/22)
   Support RTC for PC98, using mach-* scheme.
 o scsi.patch (16/22)
   SCSI host adapter support.
 o serial.patch (17/22)
   Serial port support for PC98.
 o setup.patch (18/22)
   Support difference of IO port/memory address, using mach-* scheme.
 o smp.patch (19/22)
   SMP support for PC98.
 o timer.patch (20/22)
   Support difference of timer, using mach-* scheme.
 o traps.patch (21/22)
   Support difference of NMI handling, using mach-* scheme.
 o video_card.patch (22/22)
   PC-98 standard text mode video card driver.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

