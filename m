Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264108AbTFHA2N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 20:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264115AbTFHA2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 20:28:13 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:58051 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id S264108AbTFHA2E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 20:28:04 -0400
Subject: Re: Using SATA in PATA compatible mode?
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306071132.45397.m.watts@mrw.demon.co.uk>
References: <1054932405.2156.5.camel@paragon.slim>
	 <1054947612.17190.32.camel@dhcp22.swansea.linux.org.uk>
	 <200306071132.45397.m.watts@mrw.demon.co.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1055032894.6129.6.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Jun 2003 02:41:34 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I have overcome the install problem by buying an extra plain PATA
drive...(:-( // :-) ) with the latest RH (2.4.29-18.9smp up version lock
ups (???) ) and 2.4.21-rc7-ac1 the SATA part get recognized:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta3-.2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ICH5: IDE controller at PCI slot 00:1f.1
PCI: Enabling device 00:1f.1 (0005 -> 0007)
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:pio
ICH5-SATA: IDE controller at PCI slot 00:1f.2
ICH5-SATA: chipset revision 2
ICH5-SATA: 100% native mode on irq 18
    ide2: BM-DMA at 0xef60-0xef67, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xef68-0xef6f, BIOS settings: hdg:pio, hdh:pio
hda: WDC WD1200JB-00EVA0, ATA DISK drive
blk: queue c0457500, I/O limit 4095Mb (mask 0xffffffff)
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
hde: ST3120026AS, ATA DISK drive
blk: queue c0457e08, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xefe0-0xefe7,0xefae on irq 18
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,
UDMA(100)
hde: attached ide-disk driver.
hde: host protected area => 1
hde: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=14593/255/63,
UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3
 hde: unknown partition table

But unfortunately I can't still really use the SATA drive but that's
probably due to some other problems (ACPI or SMP). Battling on...

Cheers,

Jurgen

