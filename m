Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131688AbRAaQUV>; Wed, 31 Jan 2001 11:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131998AbRAaQUL>; Wed, 31 Jan 2001 11:20:11 -0500
Received: from unimur.um.es ([155.54.1.1]:39046 "EHLO unimur.um.es")
	by vger.kernel.org with ESMTP id <S131688AbRAaQT4>;
	Wed, 31 Jan 2001 11:19:56 -0500
Message-ID: <3A783F37.F0DC9FE6@ditec.um.es>
Date: Wed, 31 Jan 2001 17:37:11 +0100
From: Juan <piernas@ditec.um.es>
X-Mailer: Mozilla 4.76 [es] (X11; U; Linux 2.4.1-pre11 i686)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Disk scheduling problems in 2.4.1-pre11?
Content-Type: multipart/mixed;
 boundary="------------025A8DE799A477A5198E64A0"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Este es un mensaje multipartes en formato MIME.
--------------025A8DE799A477A5198E64A0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi!.

I think there must be a problem in 2.4.1-pre11 regarding the disk
scheduling. Although it is suggested that hdparm is not a valid program
for benchmark purposes, I think that the different behaviour of hdparm
in 2.2.19pre7 and 2.4.1-pre11 has nothing to do with hdparm itself.

In 2.2.19pre7, hdparm works smoothly, but in 2.4.1-pre11 my disk drive
starts making noise (head movement) after 3 o 4 seconds. It seems that
that ocurrs when hdparm has read as many megabytes as RAM I have (32
MB).

Moreover, X-Windows, Netscape and StarOffice take more time to load.

Below, you have more information.

Bye.
-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968367657    Fax: +34968364151
email: piernas@ditec.um.es
PGP public key:
http://pgp.rediris.es:11371/pks/lookup?search=piernas%40ditec.um.es&op=index
--------------025A8DE799A477A5198E64A0
Content-Type: text/plain; charset=us-ascii;
 name="2.2.19-pre7.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.2.19-pre7.txt"

HDPARM TEST

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.55 seconds = 36.06 MB/sec
 Timing buffered disk reads:  64 MB in  5.91 seconds = 10.83 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.59 seconds = 35.65 MB/sec
 Timing buffered disk reads:  64 MB in  5.94 seconds = 10.77 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.44 seconds = 37.21 MB/sec
 Timing buffered disk reads:  64 MB in  5.92 seconds = 10.81 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.55 seconds = 36.06 MB/sec
 Timing buffered disk reads:  64 MB in  5.97 seconds = 10.72 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.55 seconds = 36.06 MB/sec
 Timing buffered disk reads:  64 MB in  5.97 seconds = 10.72 MB/sec

X-WINDOW, NETSCAPE AND STAROFFICE TEST
 
Steps:
 
1.- Load X-Window (see KDE 1.1.2 panel)         24 seconds
2.- Load Netscape (see Netscape window)         24 seconds
3.- Close Netscape
4.- Load StarOffice 5.1 (see StarOffice logo)   22 seconds
5.- Close StarOffice
6.- Load again Netscape                         10 seconds
7.- Close Netscape
8.- Load again StarOffice                       20 seconds

--------------025A8DE799A477A5198E64A0
Content-Type: text/plain; charset=us-ascii;
 name="2.4.1-pre11.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.1-pre11.txt"

HDPARM TEST

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.86 seconds = 33.16 MB/sec
 Timing buffered disk reads:  64 MB in  8.49 seconds =  7.54 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.76 seconds = 34.04 MB/sec
 Timing buffered disk reads:  64 MB in  9.89 seconds =  6.47 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.84 seconds = 33.33 MB/sec
 Timing buffered disk reads:  64 MB in  9.12 seconds =  7.02 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.77 seconds = 33.95 MB/sec
 Timing buffered disk reads:  64 MB in  8.29 seconds =  7.72 MB/sec

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.80 seconds = 33.68 MB/sec
 Timing buffered disk reads:  64 MB in  7.25 seconds =  8.83 MB/sec

X-WINDOW, NETSCAPE AND STAROFFICE TEST

Steps:

1.- Load X-Window (see KDE 1.1.2 panel)		30 seconds
2.- Load Netscape (see Netscape window)		24 seconds
3.- Close Netscape
4.- Load StarOffice 5.1 (see StarOffice logo)	28 seconds
5.- Close StarOffice
6.- Load again Netscape				15 seconds
7.- Close Netscape
8.- Load again StarOffice			24 seconds


--------------025A8DE799A477A5198E64A0
Content-Type: text/plain; charset=us-ascii;
 name="2.4.1-pre11.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.1-pre11.dmesg"

Linux version 2.4.1-pre11 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #21 SMP Mon Jan 29 18:08:54 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000001f00000 @ 0000000000100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c0000000 for 4096 bytes.
On node 0 totalpages: 8192
zone(0): 4096 pages.
zone(1): 4096 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01089000)
Kernel command line: BOOT_IMAGE=linux-241 ro root=305
Initializing CPU#0
Detected 200.457 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.76 BogoMIPS
Memory: 29872k/32768k available (1028k kernel code, 2508k reserved, 410k data, 208k init, 0k highmem)
Dentry-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 2048 (order: 2, 16384 bytes)
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU: After generic, caps: 008001bf 008005bf 00000000 00000000
CPU: Common caps: 008001bf 008005bf 00000000 00000000
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
CPU: Before vendor init, caps: 008001bf 008005bf 00000000, vendor = 2
CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
CPU: After vendor init, caps: 008001bf 008005bf 00000000 00000000
CPU: After generic, caps: 008001bf 008005bf 00000000 00000000
CPU: Common caps: 008001bf 008005bf 00000000 00000000
CPU0: AMD-K6tm w/ multimedia extensions stepping 02
per-CPU timeslice cutoff: 182.56 usecs.
SMP motherboard not detected. Using dummy APIC emulation.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfb250, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
DMI 2.0 present.
29 structures occupying 629 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 4.51 PG
BIOS Release: 12/11/97
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 19744kB/14808kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: FUJITSU MPC3065AH, ATA DISK drive
hdb: Maxtor 7270 AV, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12715920 sectors (6511 MB) w/512KiB Cache, CHS=791/255/63, UDMA(33)
hdb: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdb: set_drive_speed_status: error=0x04 { DriveStatusError }
hdb: 527510 sectors (270 MB) w/32KiB Cache, CHS=261/32/63, DMA
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 >
 hdb: hdb1 hdb2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 2048)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding Swap: 72256k swap-space (priority -1)

--------------025A8DE799A477A5198E64A0--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
