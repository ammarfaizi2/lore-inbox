Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTBEROr>; Wed, 5 Feb 2003 12:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbTBEROr>; Wed, 5 Feb 2003 12:14:47 -0500
Received: from [169.158.128.3] ([169.158.128.3]:25362 "EHLO mail.citma.cu")
	by vger.kernel.org with ESMTP id <S261857AbTBEROn>;
	Wed, 5 Feb 2003 12:14:43 -0500
Message-ID: <5E3B08A1.4000205@citma.cu>
Date: Wed, 05 Feb 2020 13:25:37 -0500
From: Linux Lists <user_linux@citma.cu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Lists <user_linux@citma.cu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Help with promise sx6000 card
References: <20030203221923.M79151@webmail.citma.cu>	 <1044360902.23312.16.camel@irongate.swansea.linux.org.uk>	 <5E3AE650.2010208@citma.cu> <1044461220.32062.11.camel@irongate.swansea.linux.org.uk> <5E3B06A0.40802@citma.cu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok Alan i followed your advises and  finally i got the i2o_pci module loaded.

But  I am still not able to get my card under /dev/i2o/hda.

Any clues?

Here is my dmesg output

*********************************************************
 

PDC20276: IDE controller on PCI bus 02 dev 00
PDC20276: chipset revision 1
ide: Found promise 20265 in RAID mode.
PDC20276: not 100% native mode: will probe irqs later
PDC20276: simplex device:  DMA disabled
ide2: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide3: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: IDE controller on PCI bus 02 dev 08
PDC20276: chipset revision 1
ide: Found promise 20265 in RAID mode.
PDC20276: not 100% native mode: will probe irqs later
PDC20276: simplex device:  DMA disabled
ide4: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide5: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: IDE controller on PCI bus 02 dev 10
PDC20276: chipset revision 1
ide: Found promise 20265 in RAID mode.
PDC20276: not 100% native mode: will probe irqs later
PDC20276: simplex device:  DMA disabled
ide6: PDC20276 Bus-Master DMA disabled (BIOS)
PDC20276: simplex device:  DMA disabled
ide7: PDC20276 Bus-Master DMA disabled (BIOS)
hda: WDC WD1200JB-75CRA0, ATA DISK drive
hdb: no response (status = 0xa1), resetting drive
hdb: no response (status = 0xa1)
hdc: AOPEN 16XDVD-ROM/AMH 20020328, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: setmax LBA 234441648, native  234375000
hda: 234375000 sectors (120000 MB) w/8192KiB Cache, CHS=14589/255/63, UDMA(100)
ide-floppy driver 0.99.newide
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NET4: Frame Diverter 0.46
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
pci_hotplug: PCI Hot Plug PCI Core version: 0.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 221k freed
VFS: Mounted root (ext2 filesystem).
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 13
Linux I2O PCI support (c) 1999 Red Hat Software.
i2o: Checking for PCI I2O controllers...
i2o: I2O controller on bus 0 at 81.
i2o: PCI I2O controller at 0xF9000000 size=4194304
I2O: Promise workarounds activated.
I2O: MTRR workaround for Intel i960 processor
i2o/iop0: Installed at IRQ10
i2o: 1 I2O controller found and installed.
Activating I2O controllers...
This may take a few minutes if there are many devices
i2o/iop0: Get status timeout.
Unable to obtain status of i2o/iop0, attempting a reset.
i2o/iop0: Get status timeout.
IOP reset timeout.
i2o/iop0: Get status timeout.
IOP reset timeout.
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: registered device at major 80
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 240k freed



