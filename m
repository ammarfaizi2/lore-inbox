Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315213AbSGQPg3>; Wed, 17 Jul 2002 11:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315218AbSGQPg3>; Wed, 17 Jul 2002 11:36:29 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:20426 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315213AbSGQPg2>; Wed, 17 Jul 2002 11:36:28 -0400
Date: Wed, 17 Jul 2002 17:38:48 +0200
From: kladit@t-online.de (Klaus Dittrich)
To: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: 2.4.19rc2 and Promise RAID controller
Message-ID: <20020717153848.GA3167@df1tlpc.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With 2.4.19.rc2 my Promise RAID controller will be skipped.
With 2.4.19.rc1 and before it was detected and worked fine.

from dmesg of 2.4.19rc2 ..

PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
	PDC20270: IDE controller on PCI bus 00 dev 48
	PDC20270: chipset revision 2
	ide: Skipping Promise RAID controller.
	hdb: C/H/S=20510/81/228 from BIOS ignored
	hdb: IBM-DTLA-307060, ATA DISK drive
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
	Partition check:
		 hdb: hdb1
Floppy drive(s): fd0 is 1.44M



from dmesg of 2.4.19rc1 ..

PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:pio, hdb:DMA
	ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
	PDC20270: IDE controller on PCI bus 00 dev 48
	PDC20270: chipset revision 2
	PDC20270: not 100% native mode: will probe irqs later
	ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
	ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
	hdb: C/H/S=20510/81/228 from BIOS ignored
	hdb: IBM-DTLA-307060, ATA DISK drive
	hde: WDC WD600BB-32CXA0, ATA DISK drive
	hdg: WDC WD600BB-32CXA0, ATA DISK drive
	ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
	ide2 at 0xb800-0xb807,0xb402 on irq 5
	ide3 at 0xb000-0xb007,0xa802 on irq 5
	hdb: 120103200 sectors (61493 MB) w/1916KiB Cache, CHS=119150/16/63, UDMA(33)
	hde: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
	hdg: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, (U)DMA
	Partition check:
		hdb: hdb1
		hde: hde1
		hdg: hdg1
Floppy drive(s): fd0 is 1.44M

-- 
Regards

Klaus 
