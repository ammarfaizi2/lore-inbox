Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSHaA5X>; Fri, 30 Aug 2002 20:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSHaA5X>; Fri, 30 Aug 2002 20:57:23 -0400
Received: from pcp810151pcs.nrockv01.md.comcast.net ([68.49.85.67]:10112 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S315445AbSHaA5U>;
	Fri, 30 Aug 2002 20:57:20 -0400
Date: Fri, 30 Aug 2002 21:01:46 -0400
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: 2.4.20-pre5-ac1 PDC20269 80-pin acble misdetection
Message-ID: <20020830210146.A1137@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the cables in my system are 80-pin.  On that card, one is standard
and the other rounded.  There is only one disk per channel, which may
explain the misdetection.


Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 00:10.0
PCI: Found IRQ 9 for device 00:10.0
PCI: Sharing IRQ 9 with 00:09.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0x9000-0x9007, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x9008-0x900f, BIOS settings: hdg:pio, hdh:pio
VP_IDE: IDE controller at PCI slot 00:11.1
PCI: No IRQ known for interrupt pin A of device 00:11.1. Please try using pci=biosirq.
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt8233a (rev 00) IDE UDMA133 controller on pci00:11.1
    ide0: BM-DMA at 0x8800-0x8807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x8808-0x880f, BIOS settings: hdc:DMA, hdd:DMA
hda: Maxtor 98196H8, ATA DISK drive
hdc: CREATIVE CD-RW RW1210E, ATAPI CD/DVD-ROM drive
hdd: PIONEER DVD-RW DVR-104, ATAPI CD/DVD-ROM drive
hde: Maxtor 4G160J8, ATA DISK drive
ULTRA 66/100/133: Primary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Primary channel requires an 80-pin cable for operation.
hde reduced to Ultra33 mode.
hdg: Maxtor 4G160J8, ATA DISK drive
ULTRA 66/100/133: Secondary channel of Ultra 66/100/133 requires an 80-pin cable for Ultra66 operation.
         Switching to Ultra33 mode.
Warning: Secondary channel requires an 80-pin cable for operation.
hdg reduced to Ultra33 mode.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xa400-0xa407,0xa002 on irq 9
ide3 at 0x9800-0x9807,0x9402 on irq 9
hda: host protected area => 1
hda: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
hde: host protected area => 1
hde: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdg: host protected area => 1
hdg: 320173056 sectors (163929 MB) w/2048KiB Cache, CHS=19929/255/63, UDMA(133)
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 hda10 >
 hde: hde1
 hdg: hdg1

00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: Asustek Computer, Inc.: Unknown device 807f
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: d6000000-d75fffff
        Prefetchable memory behind bridge: d7700000-dfffffff
        Capabilities: <available only to root>

00:10.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 4d69 (rev 02) (prog-if 85)
        Subsystem: Promise Technology, Inc.: Unknown device 4d68
        Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 9
        I/O ports at a400 [size=8]
        I/O ports at a000 [size=4]
        I/O ports at 9800 [size=8]
        I/O ports at 9400 [size=4]
        I/O ports at 9000 [size=16]
        Memory at d3000000 (32-bit, non-prefetchable) [size=16K]
        Expansion ROM at <unassigned> [disabled] [size=16K]
        Capabilities: <available only to root>

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: Asustek Computer, Inc.: Unknown device 808c
        Flags: bus master, medium devsel, latency 32
        I/O ports at 8800 [size=16]
        Capabilities: <available only to root>

/dev/hda:

 Model=aMtxro9 18698H                          , FwRev=AZ8H410Y, SerialNo=8V30F3CE            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=160086528
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 

/dev/hde:

 Model=Maxtor 4G160J8, FwRev=DAK019K0, SerialNo=G8000000
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 

/dev/hdg:

 Model=aMtxro4 1G068J                          , FwRev=AG8KC10K, SerialNo=8GB0VPE2            
 Config={ Fixed }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
 BuffType=DualPortCache, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=65535/1/63, CurSects=-4128706, LBA=yes, LBAsects=268435455
 IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6 
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-6 T13 1410D revision 0 : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6 

I can test things as needed, that computer is horribly unstable anyway...

  OG.
