Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271845AbTGRPGh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271772AbTGRPEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:04:53 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:54792 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S271806AbTGROfz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:35:55 -0400
To: linux-kernel@vger.kernel.org
Subject: IDE DMA errors with 2.6.0-test1
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 18 Jul 2003 16:48:42 +0200
Message-ID: <yw1x4r1jlwl1.fsf@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I was copying a couple of large files from one partition to another on
the same disk when I got a few of these messages:

hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status timeout: status=0xd0 { Busy }

hda: drive not ready for command
ide0: reset: success

The disk controller is:
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 961 MuTIOL IDE UDMA100 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
anticipatory scheduling elevator
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS SCB-2408, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: host protected area => 1
hda: 78140160 sectors (40008 MB) w/1740KiB Cache, CHS=4864/255/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3

Need I worry about anything?

-- 
Måns Rullgård
mru@users.sf.net
