Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTLAO2t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 09:28:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTLAO2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 09:28:49 -0500
Received: from mta10.adelphia.net ([68.168.78.202]:41954 "EHLO
	mta10.adelphia.net") by vger.kernel.org with ESMTP id S263809AbTLAO2q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 09:28:46 -0500
Date: Mon, 1 Dec 2003 09:28:40 -0500
From: mikepolniak <mikpolniak@adelphia.net>
To: linux-kernel@vger.kernel.org
Subject: vt8235 ide0: Speed warnings UDMA 3/4/5 is not functional
Message-ID: <20031201142840.GB4192@gent.gentuu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a new Shuttle MK40VN motherboard with VIA KM400 and VT8235. I have
tried kernel 2.6.0-test11 and 2.4.23 and only can get UDMA2 working on my
hard drive.

If i try hdparm -X69 -d 1 /dev/hda i get the speed warnings:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2 ide: Assuming
33MHz system bus speed for PIO modes; override with idebus=xx VP_IDE: IDE
controller at PCI slot 0000:00:11.1 VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later VP_IDE: VIA vt8235
(rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio ide1:
    BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 p9 p10 p11
 p12 >
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX
as
device
scsi0 : SCSI host adapter emulation for IDE ATAPI devices Linux video
capture interface: v1.00
ide0: Speed warnings UDMA 3/4/5 is not functional. ide0: Speed warnings
UDMA 3/4/5 is not functional. ide0: Speed warnings UDMA 3/4/5 is not
functional.
-- 

