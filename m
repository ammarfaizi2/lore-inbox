Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310950AbSCHS7i>; Fri, 8 Mar 2002 13:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311006AbSCHS7T>; Fri, 8 Mar 2002 13:59:19 -0500
Received: from mail.infraxs.com ([213.170.58.89]:41099 "HELO mail.infraxs.com")
	by vger.kernel.org with SMTP id <S310950AbSCHS7M> convert rfc822-to-8bit;
	Fri, 8 Mar 2002 13:59:12 -0500
content-class: urn:content-classes:message
Subject: 2.4.17 & HPT370 raid
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Fri, 8 Mar 2002 19:59:06 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <64BA755D4BD38F4EBA330020C11C5F1C746D@infradc03.infraxs-nl.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.17 & HPT370 raid
Thread-Index: AcHG01I2aNw7Y/cgRtK6clXkZTEu9g==
From: "Jeroen Geusebroek" <j.geusebroek@infraxs.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm trying to use the raid function of my motherboard (abit vp6) which has a HPT370 controller.
I compiled the kernel with HPTP370 support & also the support for HPT370 raid.

Everything seems to be working correctly, but i don't have the /dev/ataraid devices. 
My kernel does shows it detected the harddisks correctly:

VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xe000-0xe007, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xe008-0xe00f, BIOS settings: hdg:DMA, hdh:pio
hda: Maxtor 5T060H6, ATA DISK drive
hde: Maxtor 5T030H3, ATA DISK drive
hdg: Maxtor 5T030H3, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xd000-0xd007,0xd402 on irq 11
ide3 at 0xd800-0xd807,0xdc02 on irq 11
hda: 120103200 sectors (61493 MB) w/2048KiB Cache, CHS=7476/255/63, UDMA(100)
hde: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
hdg: 60030432 sectors (30736 MB) w/2048KiB Cache, CHS=59554/16/63, UDMA(100)
Partition check:
 hda: hda1 < hda5 hda6 hda7 hda8 hda9 hda10 > hda2
 hde: unknown partition table
 hdg: unknown partition table
------
 ataraid/d0: unknown partition table
Highpoint HPT370 Softwareraid driver for linux version 0.01
Drive 0 is 29311 Mb 
Drive 1 is 29311 Mb 
Raid array consists of 2 drives. 
-------------

Did i forget anything? Do i have to create the /dev/ataraid devices myself?

Thanks,

Jeroen

