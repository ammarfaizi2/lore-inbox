Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318256AbSIBKID>; Mon, 2 Sep 2002 06:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSIBKID>; Mon, 2 Sep 2002 06:08:03 -0400
Received: from radium.jvb.tudelft.nl ([130.161.82.13]:17797 "EHLO
	radium.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S318256AbSIBKIA>; Mon, 2 Sep 2002 06:08:00 -0400
From: "Robbert Kouprie" <robbert@radium.jvb.tudelft.nl>
To: <andre@linux-ide.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.xx IDE development policy
Date: Mon, 2 Sep 2002 12:10:58 +0200
Message-ID: <00a701c25269$083e0080$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre et al,

Just to add some more positivity: I'm running 2.4.18-ac and 2.4.19-pre
and stable kernels (currently 2.4.19-rc3 vanilla) for a while now on my
fileserver. It has 1 onboard VIA and 2 PCI Promise controllers and a
total of 6 disks attached (every disk on its own cable). I kept the BIOS
versions of the Promise controllers up to date all the time. All disks
are running automagically - without passing kernel options - on their
max possible UDMA transfer rate, and even the 160Gb LBA48 disk is
behaving fine. The disks are in constant heavy use as fileserver for
500+ clients. With respect to IDE, the system is rock solid for a long
time now, and I have never ever seen even a little bit of data
corruption.

Regards,
- Robbert Kouprie

Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio
PDC20269: IDE controller on PCI bus 00 dev 50
PCI: Found IRQ 11 for device 00:0a.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER
Mode.
    ide2: BM-DMA at 0xcc00-0xcc07, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdg:pio, hdh:pio
PDC20267: IDE controller on PCI bus 00 dev 58
PCI: Found IRQ 10 for device 00:0b.0
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide4: BM-DMA at 0xe000-0xe007, BIOS settings: hdi:DMA, hdj:pio
    ide5: BM-DMA at 0xe008-0xe00f, BIOS settings: hdk:DMA, hdl:pio
hda: ST34321A, ATA DISK drive
hdc: Maxtor 54098U8, ATA DISK drive
hde: Maxtor 4G160J8, ATA DISK drive
hdg: WDC WD1200BB-00CAA0, ATA DISK drive
hdi: Maxtor 94098U8, ATA DISK drive
hdk: Maxtor 98196H8, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xbc00-0xbc07,0xc002 on irq 11
ide3 at 0xc400-0xc407,0xc802 on irq 11
ide4 at 0xd000-0xd007,0xd402 on irq 10
ide5 at 0xd800-0xd807,0xdc02 on irq 10
hda: 8404830 sectors (4303 MB) w/128KiB Cache, CHS=523/255/63, UDMA(33)
hdc: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63,
UDMA(66)
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63,
UDMA(133)
hdg: 234441648 sectors (120034 MB) w/2048KiB Cache, CHS=232581/16/63,
UDMA(100)
hdi: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=79406/16/63,
UDMA(66)
hdk: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=158816/16/63,
UDMA(100)

