Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbTHCSTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271223AbTHCSTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:19:47 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:35489 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S266141AbTHCSTq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:19:46 -0400
Subject: 2.4.22pre10-ac1: ICH5 SATA missing in action
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1059934705.2789.8.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-1) 
Date: 03 Aug 2003 20:18:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.22pre10-ac1 the SATA part of the ICH5 is no longer
found or recognized. With a plain 2.4.22pre3 (last 2.4.22pre I tested)
it was working properly.

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC WD1200JB-00EVA0, ATA DISK drive
blk: queue c033ab60, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,
UDMA(100)

I am not sure if this was reported already.

Greetings,

Jurgen

