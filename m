Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTDKC0N (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 22:26:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTDKC0N (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 22:26:13 -0400
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:28544 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP id S264289AbTDKC0M (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 22:26:12 -0400
Date: Fri, 11 Apr 2003 11:35:43 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET] Support PC-9800 sub-architecture for 2.5.67-bk2
Message-ID: <20030411023543.GA1059@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for merging PC-9800 support patches.
Here is the patchset to support NEC PC-9800 subarchitecture
against 2.5.67-bk2.
http://downloads.sourceforge.jp/linux98/3197/linux98-2.5.67-bk2.patch.tar.bz2

Comments and test reports are wellcome.

Description:
 Update for merged files.
 o fs-update.patch (1/1)
   Fix compilation when configure PC98 partition and BSD disk label.

 Additional patches
 o apm.patch (1/16)
   APM support for PC98. Including PC98's BIOS bug fix.
 o arch.patch (2/16)
   Config and Make for PC98.
 o console.patch (3/16)
   PC98 Standard console support (without japanese kanji character).
 o core-misc.patch (4/16)
   Small patches for PC98 support core.
 o core.patch (5/16)
   Patches for PC98 support core.
 o dma.patch (6/16)
   DMA support for PC98.
 o ide.patch (7/16)
   PC98 standard IDE I/F support.
 o kanji.patch (8/16)
   japanese kanji character support for PC98 console.
 o parport.patch (9/16)
   Parallel port support.
 o pci.patch (10/16)
   Small changes for PCI support.
 o pcmcia.patch (11/16)
   Small change for PCMCIA (16bits) support.
 o rtc.patch (12/16)
   Support RTC for PC98, using mach-* scheme.
 o scsi.patch (13/16)
   SCSI host adapter support.
 o smp.patch (14/16)
   SMP support for PC98.
 o timer.patch (15/16)
   Support difference of timer, using mach-* scheme.
 o video_card.patch (16/16)
   PC-98 standard text mode video card driver.

Regards,
Osamu Tomita <tomita@cinet.co.jp>

