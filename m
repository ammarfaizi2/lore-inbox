Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316132AbSENXDL>; Tue, 14 May 2002 19:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316133AbSENXDK>; Tue, 14 May 2002 19:03:10 -0400
Received: from h24-71-223-10.cg.shawcable.net ([24.71.223.10]:46958 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id <S316132AbSENXDG>; Tue, 14 May 2002 19:03:06 -0400
Date: Tue, 14 May 2002 16:50:13 -0700
From: Andre LeBlanc <ap.leblanc@shaw.ca>
Subject: Re: No Network after Compiling,
 2.4.19-pre8 under Debian Woody (Long Message)
To: bert hubert <ahu@ds9a.nl>
Cc: linux-kernel@vger.kernel.org
Message-id: <000c01c1fba2$1779da60$2000a8c0@metalbox>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <003c01c1fb9d$345e0a20$2000a8c0@metalbox>
 <20020514202912.GA18544@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok heres the dmesg with 2.4.19-pre8:

------*******-----

Linux version 2.4.19-pre8 (root@metalbox) (gcc version 2.95.4 20011002
(Debian prerelease)) #3 Tue May 14 11:56:35 EDT 2002

BIOS-provided physical RAM map:

BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)

BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)

BIOS-e820: 0000000017ff0000 - 0000000017ff3000 (ACPI NVS)

BIOS-e820: 0000000017ff3000 - 0000000018000000 (ACPI data)

BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)

383MB LOWMEM available.

On node 0 totalpages: 98288

zone(0): 4096 pages.

zone(1): 94192 pages.

zone(2): 0 pages.

Kernel command line: BOOT_IMAGE=Linux ro root=303

Initializing CPU#0

Detected 1002.275 MHz processor.

Console: colour VGA+ 80x25

Calibrating delay loop... 1998.84 BogoMIPS

Memory: 386184k/393152k available (1435k kernel code, 6580k reserved, 455k
data, 232k init, 0k highmem)

Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)

Inode cache hash table entries: 32768 (order: 6, 262144 bytes)

Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)

Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)

Page-cache hash table entries: 131072 (order: 7, 524288 bytes)

CPU: Before vendor init, caps: 0383f9ff c1cbf9ff 00000000, vendor = 2

CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)

CPU: L2 Cache: 64K (64 bytes/line)

CPU: After vendor init, caps: 0383f9ff c1cbf9ff 00000000 00000000

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: After generic, caps: 0383f9ff c1cbf9ff 00000000 00000000

CPU: Common caps: 0383f9ff c1cbf9ff 00000000 00000000

CPU: AMD Duron(tm) processor stepping 01

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)

mtrr: detected mtrr type: Intel

PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=1

PCI: Using configuration type 1

PCI: Probing PCI hardware

Unknown bridge resource 0: assuming transparent

PCI: Using IRQ router SIS [1039/0008] at 00:01.0

isapnp: Scanning for PnP cards...

isapnp: No Plug & Play device found

Linux NET4.0 for Linux 2.4

Based upon Swansea University Computer Society NET3.039

Initializing RT netlink socket

Starting kswapd

Installing knfsd (copyright (C) 1996 okir@monad.swb.de).

parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]

parport0: irq 7 detected

pty: 256 Unix98 ptys configured

Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled

ttyS00 at 0x03f8 (irq = 4) is a 16550A

PCI: Found IRQ 9 for device 00:01.6

PCI: Sharing IRQ 9 with 00:0b.0

Uniform Multi-Platform E-IDE driver Revision: 6.31

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx

SIS5513: IDE controller on PCI bus 00 dev 01

SIS5513: chipset revision 208

SIS5513: not 100% native mode: will probe irqs later

SiS730

ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA

ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio

hda: FUJITSU MPG3307AT, ATA DISK drive

hdb: AOPEN CRW1232, ATAPI CD/DVD-ROM drive

hdc: TOSHIBA DVD-ROM SD-M1502, ATAPI CD/DVD-ROM drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

ide1 at 0x170-0x177,0x376 on irq 15

hda: 60046560 sectors (30744 MB) w/2048KiB Cache, CHS=3971/240/63, UDMA(100)

hdb: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA

Uniform CD-ROM driver Revision: 3.12

hdc: ATAPI 48X DVD-ROM drive, 128kB Cache, UDMA(33)

Partition check:

hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

loop: loaded (max 8 devices)

8139too Fast Ethernet driver 0.9.24

PCI: Found IRQ 5 for device 00:09.0

eth0: SMC1211TX EZCard 10/100 (RealTek RTL8139) at 0xd8800000,
00:e0:29:94:ca:bc, IRQ 5

eth0: Identified 8139 chip type 'RTL-8139C'

PCI: Found IRQ 11 for device 00:0d.0

PCI: Sharing IRQ 11 with 00:01.2

PCI: Sharing IRQ 11 with 00:01.3

eth1: RealTek RTL8139 Fast Ethernet at 0xd8802000, 00:07:95:ad:61:d6, IRQ 11

eth1: Identified 8139 chip type 'RTL-8139C'

Linux agpgart interface v0.99 (c) Jeff Hartmann

agpgart: Maximum main memory to use for agp memory: 321M

agpgart: Detected SiS 730 chipset

agpgart: AGP aperture is 64M @ 0xd8000000

[drm] Initialized tdfx 1.0.0 20010216 on minor 0

[drm] AGP 0.99 on SiS @ 0xd8000000 64MB

[drm] Initialized radeon 1.1.1 20010405 on minor 1

SCSI subsystem driver Revision: 1.00

scsi0 : SCSI host adapter emulation for IDE ATAPI devices

Creative EMU10K1 PCI Audio Driver, version 0.18, 11:58:56 May 14 2002

PCI: Found IRQ 9 for device 00:0b.0

PCI: Sharing IRQ 9 with 00:01.6

emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xdc00-0xdc1f, IRQ 9

ac97_codec: AC97 codec, id: 0x5452:0x4123 (TriTech TR A5)

Linux Kernel Card Services 3.1.22

options: [pci] [cardbus] [pm]

usb.c: registered new driver hub

uhci.c: USB Universal Host Controller Interface driver v1.1

Initializing USB Mass Storage driver...

usb.c: registered new driver usb-storage

USB Mass Storage support registered.

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

IP: routing cache hash table of 4096 buckets, 32Kbytes

TCP: Hash tables configured (established 32768 bind 32768)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

ds: no socket drivers loaded!

VFS: Mounted root (ext2 filesystem) readonly.

Freeing unused kernel memory: 232k freed

Adding Swap: 506480k swap-space (priority -1)

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }

hdb: DMA disabled

ide0: reset: success

eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

eth0: Setting half-duplex based on auto-negotiated partner ability 0000.

_______*******_______

Heres the ifconfig before pinging:

_______*******_______

eth0 Link encap:Ethernet HWaddr 00:E0:29:94:CA:BC

UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1

RX packets:0 errors:0 dropped:0 overruns:0 frame:0

TX packets:6 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:100

RX bytes:0 (0.0 b) TX bytes:2052 (2.0 KiB)

Interrupt:5

lo Link encap:Local Loopback

inet addr:127.0.0.1 Mask:255.0.0.0

UP LOOPBACK RUNNING MTU:16436 Metric:1

RX packets:8 errors:0 dropped:0 overruns:0 frame:0

TX packets:8 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:0

RX bytes:560 (560.0 b) TX bytes:560 (560.0 b)


___________**************___________

Then i tried to ping 192.168.0.1 (My Firewall/DHCP Server)

then ran ifconfig again

__________************__________

eth0 Link encap:Ethernet HWaddr 00:E0:29:94:CA:BC

UP BROADCAST RUNNING MULTICAST MTU:1500 Metric:1

RX packets:0 errors:0 dropped:0 overruns:0 frame:0

TX packets:6 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:100

RX bytes:0 (0.0 b) TX bytes:2052 (2.0 KiB)

Interrupt:5

lo Link encap:Local Loopback

inet addr:127.0.0.1 Mask:255.0.0.0

UP LOOPBACK RUNNING MTU:16436 Metric:1

RX packets:8 errors:0 dropped:0 overruns:0 frame:0

TX packets:8 errors:0 dropped:0 overruns:0 carrier:0

collisions:0 txqueuelen:0

RX bytes:560 (560.0 b) TX bytes:560 (560.0 b)

______________***************___________

Heres the dmesg from the 2.2.20 kernel just for reference



_______________*************______________

Linux version 2.2.20 (herbert@gondolin) (gcc version 2.7.2.3) #1 Mon Dec 31
07:05:08 EST 2001

BIOS-provided physical RAM map:

BIOS-e820: 0009f000 @ 00000000 (usable)

BIOS-e820: 17ef0000 @ 00100000 (usable)

Detected 1002293 kHz processor.

Console: colour VGA+ 80x25

Calibrating delay loop... 1998.84 BogoMIPS

Memory: 386576k/393152k available (1756k kernel code, 412k reserved, 4256k
data, 152k init)

Dentry hash table entries: 65536 (order 7, 512k)

Buffer cache hash table entries: 524288 (order 9, 2048k)

Page cache hash table entries: 131072 (order 7, 512k)

VFS: Diskquotas version dquot_6.4.0 initialized

CPU: L1 I Cache: 64K L1 D Cache: 64K

CPU: L2 Cache: 64K

CPU: AMD Duron(tm) processor stepping 01

Checking 386/387 coupling... OK, FPU using exception 16 error reporting.

Checking 'hlt' instruction... OK.

Checking for popad bug... OK.

POSIX conformance testing by UNIFIX

mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)

PCI: PCI BIOS revision 2.10 entry at 0xfb370

PCI: Using configuration type 1

PCI: Probing PCI hardware

Linux NET4.0 for Linux 2.2

Based upon Swansea University Computer Society NET3.039

NET4: Linux TCP/IP 1.0 for NET4.0

IP Protocols: ICMP, UDP, TCP, IGMP

TCP: Hash tables configured (ehash 524288 bhash 65536)

Starting kswapd v 1.5

Serial driver version 4.27 with HUB-6 MANY_PORTS MULTIPORT SHARE_IRQ enabled

ttyS00 at 0x03f8 (irq = 4) is a 16550A

pty: 256 Unix98 ptys configured

Real Time Clock Driver v1.09

RAM disk driver initialized: 16 RAM disks of 4096K size

loop: registered device at major 7

SIS5513: IDE controller on PCI bus 00 dev 01

SIS5513: not 100% native mode: will probe irqs later

ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:DMA

ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:DMA, hdd:pio

hda: FUJITSU MPG3307AT, ATA DISK drive

hdb: AOPEN CRW1232, ATAPI CDROM drive

hdc: TOSHIBA DVD-ROM SD-M1502, ATAPI CDROM drive

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

ide1 at 0x170-0x177,0x376 on irq 15

hda: FUJITSU MPG3307AT, 29319MB w/2048kB Cache, CHS=3971/240/63

hdb: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache

Uniform CD-ROM driver Revision: 3.11

hdc: ATAPI 48X DVD-ROM drive, 128kB Cache

Floppy drive(s): fd0 is 1.44M

FDC 0 is a post-1991 82077

md driver 0.36.6 MAX_MD_DEV=4, MAX_REAL=8

scsi: <fdomain> Detection failed (no card)

NCR53c406a: no available ports found

sym53c416.c: Version 1.0.0

Failed initialization of WD-7000 SCSI card!

IBM MCA SCSI: Version 3.2

IBM MCA SCSI: No Microchannel-bus present --> Aborting.

This machine does not have any IBM MCA-bus

or the MCA-Kernel-support is not enabled!

megaraid: v1.11 (Aug 23, 2000)

aec671x_detect:

3ware Storage Controller device driver for Linux v1.02.00.008.

3w-xxxx: tw_findcards(): No cards found.

scsi : 0 hosts.

scsi : detected total.

Partition check:

hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >

apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)

apm: disabled on user request.

VFS: Mounted root (ext2 filesystem) readonly.

Freeing unused kernel memory: 152k freed

NET4: Unix domain sockets 1.0 for Linux NET4.0.

Adding Swap: 506480k swap-space (priority -1)

eth0: 8139too Fast Ethernet driver 0.9.18-pre4 Jeff Garzik
<jgarzik@mandrakesoft.com>

eth0: Linux-2.2 bug reports to Jens David <dg1kjd@afthd.tu-darmstadt.de>

eth0: RealTek RTL8139 Fast Ethernet board found at 0xd8050000, IRQ 11

eth0: Chip is 'RTL-8139C' - MAC address '00:07:95:ad:61:d6'.

eth1: SMC1211TX EZCard 10/100 (RealTek RTL8139) board found at 0xd8052000,
IRQ 5

eth1: Chip is 'RTL-8139C' - MAC address '00:e0:29:94:ca:bc'.

Creative EMU10K1 PCI Audio Driver, version 0.7, 07:13:36 Dec 31 2001

emu10k1: EMU10K1 rev 8 model 0x8027 found, IO at 0xdc00-0xdc1f, IRQ 9

eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability
41e1.

eth0: Setting 100mbps full-duplex based on auto-negotiated partner ability
41e1.



__________**********___________

I also noticed that when booting, the 2.2.20 kernel identifies media type
100MBit Full duplex, and under 2.4.19-pre8 it detects 10MBit half duplex.,
if that makes a difference




----- Original Message -----
From: "bert hubert" <ahu@ds9a.nl>
To: "Andre LeBlanc" <ap.leblanc@shaw.ca>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, May 14, 2002 1:29 PM
Subject: Re: No Network after Compiling, 2.4.19-pre8 under Debian Woody


> On Tue, May 14, 2002 at 04:15:14PM -0700, Andre LeBlanc wrote:
> > Ok, the system is a Duron 1GHz on an ECS Motherboard with the SiS 730S
> > Chipset. 384 MB PC133, with a realtek 8139 based Nic.
> > heres the .config
> >
> > network works fine if I boot the old(2.2.20) kernel but booting
2.4.19-pre8
> > causes me to have no network connection, But the device is configured
> > properly. (I Think)
> > I can also send my dmesg if it will help
>
> Please do. Also show the output of ifconfig before and after trying to
ping
> some hosts.
>
> --
> http://www.PowerDNS.com          Versatile DNS Software & Services
> http://www.tk                              the dot in .tk
> http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

