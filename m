Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbSITOUN>; Fri, 20 Sep 2002 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSITOUN>; Fri, 20 Sep 2002 10:20:13 -0400
Received: from k100-28.bas1.dbn.dublin.eircom.net ([159.134.100.28]:21259 "EHLO
	corvil.com.") by vger.kernel.org with ESMTP id <S262675AbSITOUL>;
	Fri, 20 Sep 2002 10:20:11 -0400
Message-ID: <3D8B2F8D.7030307@corvil.com>
Date: Fri, 20 Sep 2002 15:24:13 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: hdparm -Y hangup
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems like a bug in the ide driver not issuing a reset?

On RH7.3 (2.4.18-3) if I do:
$ hdparm -Y /dev/hda
$ do stuff and disk spins up
$ hdparm -Y /dev/hda
$ everything hangs waiting for disk

cheers,
Pádraig.

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: Maxtor 4D040H2, ATA DISK drive
hdc: SAMSUNG CD-ROM SC-148C, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c035e6a4, I/O limit 4095Mb (mask 0xffffffff)
hda: 78125000 sectors (40000 MB) w/2048KiB Cache, CHS=4863/255/63, UDMA(66)
ide-floppy driver 0.99.newide
Partition check:
  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >

