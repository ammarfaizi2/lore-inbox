Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276369AbRJPQ3n>; Tue, 16 Oct 2001 12:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276451AbRJPQ3Z>; Tue, 16 Oct 2001 12:29:25 -0400
Received: from mailrelay1.inwind.it ([212.141.54.101]:9459 "EHLO
	mailrelay1.inwind.it") by vger.kernel.org with ESMTP
	id <S276369AbRJPQ3K>; Tue, 16 Oct 2001 12:29:10 -0400
Message-ID: <3BCC6062.331D4B02@inwind.it>
Date: Tue, 16 Oct 2001 18:29:22 +0200
From: Michele Mencacci <shire@inwind.it>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.19 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re:HD Problem.
Content-Type: multipart/mixed;
 boundary="------------4EC5DCD92B0997E5106449F0"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4EC5DCD92B0997E5106449F0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I'm using 2.4.13-pre1.
here my dmesg reports:
the 1st is 2.4.13-pre1. The /dev/hdd errors was when it was trying to
write the partition table with fdisk.

the 2nd instead is dmesg for 2.2.19.
Thanx for all

		Mike
--------------4EC5DCD92B0997E5106449F0
Content-Type: text/plain; charset=us-ascii;
 name="test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test"

Linux version 2.4.13-pre1 (root@shire) (gcc version 2.95.3 20010315 (release)) #2 mar ott 16 16:54:45 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000006000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 24576
zone(0): 4096 pages.
zone(1): 20480 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda2 mem=98304K
Initializing CPU#0
Detected 233.868 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 94320k/98304k available (1241k kernel code, 3596k reserved, 382k data, 200k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
CPU: Before vendor init, caps: 008001bf 00000000 00000000, vendor = 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 008001bf 00000000 00000000 00000000
CPU:     After generic, caps: 008001bf 00000000 00000000 00000000
CPU:             Common caps: 008001bf 00000000 00000000 00000000
CPU: Intel Pentium MMX stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb730, last bus=0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
parport0: PC-style at 0x378 [PCSPP(,...)]
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
lp0: using parport0 (polling).
block: 128 slots per queue, batch=16
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG VG33402A (3.40GB), ATA DISK drive
hdb: Maxtor 72004 AP, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6602B, ATAPI CD/DVD-ROM drive
hdd: WDC AC2340H, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6643728 sectors (3402 MB) w/112KiB Cache, CHS=6591/16/63, UDMA(33)
hdb: 3924360 sectors (2009 MB) w/128KiB Cache, CHS=3893/16/63, DMA
hdd: 666600 sectors (341 MB) w/128KiB Cache, CHS=1010/12/55
hdc: ATAPI 40X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
 hdd: unknown partition table
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 62M
agpgart: no supported devices found.
[drm] Initialized tdfx 1.0.0 20010216 on minor 0
[drm] Initialized radeon 1.1.1 20010405 on minor 1
es1371: version v0.30 time 17:08:22 Oct 16 2001
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
usb.c: registered new driver hub
uhci.c: USB Universal Host Controller Interface driver v1.1
uhci.c: USB UHCI at I/O 0x6400, IRQ 11
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
ds: no socket drivers loaded!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 200k freed
VFS: Disk change detected on device ide1(22,0)
hdd: read_intr: status=0x75 { DriveReady DeviceFault SeekComplete CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
hdc: DMA disabled
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
 hdd:hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
 unknown partition table
 hdd:hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
 unknown partition table
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
hdd: read_intr: status=0x65 { DriveReady DeviceFault CorrectedError Error }
hdd: read_intr: error=0x04 { DriveStatusError }
ide1: reset: success
Loading Lucent Modem Controller driver version 6.00
Detected Parameters Irq=10 BaseAddress=0x6600 ComAddress=0x6500
Lucent Modem Interface driver version 6.00 (2001-01-26) with SHARE_IRQ enabled
ttyLT00 at 0x6600 (irq = 10) is a Lucent Modem



--------------4EC5DCD92B0997E5106449F0
Content-Type: text/plain; charset=us-ascii;
 name="test1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test1"

Linux version 2.2.19 (root@shire) (gcc version 2.95.3 20010315 (release)) #3 Mon Oct 15 22:52:52 CEST 2001
USER-provided physical RAM map:
 USER: 000a0000 @ 00000000 (usable)
 USER: 05f00000 @ 00100000 (usable)
Detected 233868 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 466.94 BogoMIPS
Memory: 95592k/98304k available (1064k kernel code, 412k reserved, 1192k data, 44k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 131072 (order 7, 512k)
Page cache hash table entries: 32768 (order 5, 128k)
CPU: Intel Pentium MMX stepping 03
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfb730
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 131072 bhash 65536)
Starting kswapd v 1.5 
parport0: PC-style at 0x378 [SPP,PS2]
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
loop: registered device at major 7
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: SAMSUNG VG33402A (3.40GB), ATA DISK drive
hdb: Maxtor 72004 AP, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6602B, ATAPI CDROM drive
hdd: WDC AC2340H, ATA DISK drive
ide2: ports already in use, skipping probe
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: SAMSUNG VG33402A (3.40GB), 3244MB w/112kB Cache, CHS=6591/16/63, UDMA
hdb: Maxtor 72004 AP, 1916MB w/128kB Cache, CHS=3893/16/63, DMA
hdd: WDC AC2340H, 325MB w/128kB Cache, CHS=1010/12/55
hdc: ATAPI 40X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PPP: version 2.3.7 (demand dialling)
TCP compression code copyright 1989 Regents of the University of California
PPP line discipline registered.
PPP BSD Compression module registered
PPP Deflate Compression module registered
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1
 hdd: hdd1 hdd2
usb.c: registered new driver hub
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 44k freed
Loading Lucent Modem Controller driver version 6.00
VFS: Disk change detected on device ide1(22,0)
registered device ppp0
Detected Parameters Irq=10 BaseAddress=0x6600 ComAddress=0x6500
Lucent Modem Interface driver version 6.00
ttyLT00 at 0x6600 (irq = 10) is a Lucent Modem


--------------4EC5DCD92B0997E5106449F0--

