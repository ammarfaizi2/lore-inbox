Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263362AbSLZTXS>; Thu, 26 Dec 2002 14:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbSLZTXS>; Thu, 26 Dec 2002 14:23:18 -0500
Received: from 217-126-207-69.uc.nombres.ttd.es ([217.126.207.69]:5898 "EHLO
	server01.nullzone.prv") by vger.kernel.org with ESMTP
	id <S263362AbSLZTXR>; Thu, 26 Dec 2002 14:23:17 -0500
Message-Id: <5.1.1.6.2.20021226203107.00ce65a0@192.168.2.131>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Thu, 26 Dec 2002 20:32:00 +0100
To: linux-kernel@vger.kernel.org
From: system_lists@nullzone.org
Subject: Highpoint HPT370 not working in 2.4.18+ versions - ANY IDEA?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

    i have a Highpoint 370 which doesnt work in new kernel releases.
    I'm just using 2.4.18 becouse other version upper doesnt detect the 
Raid HW card.

Actualy i get this message with 2.4.18 (getting the most important about 
this one):

--------
VP_IDE: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
HPT370A: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
HPT370A: chipset revision 4
HPT370A: not 100% native mode: will probe irqs later
     ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio
hda: FUJITSU MPA3026ATU, ATA DISK drive
hde: ST380020A, ATA DISK drive
hdf: ST360020A, ATA DISK drive
hdg: ST380020A, ATA DISK drive
hdh: ST360020A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide2 at 0xb000-0xb007,0xb402 on irq 11
ide3 at 0xb800-0xb807,0xbc02 on irq 11
hda: 5126964 sectors (2625 MB), CHS=635/128/63
hde: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(33)
hdf: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
hdg: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=155061/16/63, UDMA(33)
hdh: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
Partition check:
  hda: hda1 hda2 hda3 hda4
  hde: unknown partition table
  hdf: unknown partition table
  hdg: [PTBL] [9729/255/63] hdg1
  hdh: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
  ataraid/d0: ataraid/d0p1
Highpoint HPT370 Softwareraid driver for linux version 0.01
Drive 0 is 76319 Mb
Drive 1 is 57241 Mb
Raid array consists of 2 drives.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
--------

With new version o get only the:
...
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 96M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd8000000
Highpoint HPT370 Softwareraid driver for linux version ...
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
...
and its all....

May any tell me what is going bad with my card? is just a problem of drivers?

Seeya

Note: add to this .. if i set the IDE driver over UDMA33 i get DMA timeouts 
and the system halt. Seeting UDMA to 33 the systems works withput problems 
or needing any intervention for months.

