Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSHZMUZ>; Mon, 26 Aug 2002 08:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSHZMUZ>; Mon, 26 Aug 2002 08:20:25 -0400
Received: from isis.telemach.net ([213.143.65.10]:11533 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S318097AbSHZMUX>;
	Mon, 26 Aug 2002 08:20:23 -0400
Date: Mon, 26 Aug 2002 14:14:04 +0200
From: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATA err with 2.4.20-ac1
Message-Id: <20020826141404.3a73e8ed.Gregor.Fajdiga@telemach.net>
In-Reply-To: <1030355630.16767.30.camel@irongate.swansea.linux.org.uk>
References: <20020826103525.7817bb4e.Gregor.Fajdiga@telemach.net>
	<1030355630.16767.30.camel@irongate.swansea.linux.org.uk>
X-Mailer: Sylpheed version 0.7.3 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,
 
> If people report IDE stuff I need to know the context, dmesg, controller
> and drives. 

/dev/hda/: Maxtor 91021U2
dev/hdb: ST31722A

______________________________dmesg output_________________________________

Linux version 2.4.20-pre4-ac1 (grega@mujo) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 ned avg 25 13:59:45 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000002000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
32MB LOWMEM available.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
Kernel command line: ro root=/dev/hda8
Initializing CPU#0
Detected 199.435 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.13 BogoMIPS
Memory: 30256k/32768k available (1004k kernel code, 2128k reserved, 263k data, 236k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=3782 max_file_pages=0 max_inodes=0 max_dentries=3782
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb140, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: SB audio device quirk - increasing port range
isapnp: AWE32 quirk - adding two ports
isapnp: Card 'Creative SB AWE64 Gold'
isapnp: 1 Plug & Play card detected total
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe30
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbe58, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
PnPBIOS: PNP0c02: ioport range 0x208-0x20f has been reserved
PnPBIOS: PNP0c02: ioport range 0x398-0x399 has been reserved
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
parport0: PC-style at 0x378 [PCSPP(,...)]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
lp0: using parport0 (polling).
Real Time Clock Driver v1.10e
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha1
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 91021U2, ATA DISK drive
hdb: ST31722A, ATA DISK drive
hdc: FX240S, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: host protected area => 1
hda: 20010816 sectors (10246 MB) w/512KiB Cache, CHS=1245/255/63, UDMA(33)
hdb: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hdb: task_no_data_intr: error=0x04 { DriveStatusError }
hdb: 3329424 sectors (1705 MB) w/128KiB Cache, CHS=825/64/63, UDMA(33)
hdc: ATAPI 24X CD-ROM drive, 256kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 >
 hdb: hdb1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 128480k swap-space (priority -1)
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,8), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.18, 14 May 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: DMA disabled
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
eth0: RealTek RTL-8029 found at 0x6600, IRQ 11, 00:4F:49:09:8B:44.
Soundblaster audio driver Copyright (C) by Hannu Savolainen 1993-1996
sb: Creative SB AWE64 Gold detected
sb: ISAPnP reports 'Creative SB AWE64 Gold' at i/o 0x220, irq 5, dma 1, 5
SB 4.16 detected OK (220)
<Sound Blaster 16 (4.16)> at 0x220 irq 5 dma 1,5
<Sound Blaster 16> at 0x330 irq 5 dma 0,0
sb: 1 Soundblaster PnP card(s) found.
_____________________dmesg end_______________


lspci output


00:00.0 Host bridge: Intel Corp. 430TX - 82439TX MTXC (rev 01)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 01)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 01)
00:09.0 Multimedia video controller: 3Dfx Interactive, Inc. Voodoo 2 (rev 02)
00:0a.0 VGA compatible controller: ATI Technologies Inc 3D Rage II+ 215GTB [Mach64 GTB] (rev 9a)
00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)

I found these messages when grepping dmesg. Is that what you meant by 
"context"

Regards,
Grega
