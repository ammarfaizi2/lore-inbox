Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbRAUWM0>; Sun, 21 Jan 2001 17:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbRAUWMQ>; Sun, 21 Jan 2001 17:12:16 -0500
Received: from bastion-larural.larural.es ([195.76.42.3]:10508 "EHLO
	srvcorreo.larural.es") by vger.kernel.org with ESMTP
	id <S129806AbRAUWMG>; Sun, 21 Jan 2001 17:12:06 -0500
Message-ID: <3A6BB2B2.9DB36E01@ditec.um.es>
Date: Sun, 21 Jan 2001 23:10:26 -0500
From: piernas@ditec.um.es
X-Mailer: Mozilla 4.72 [es] (X11; U; Linux 2.2.16dfs i586)
X-Accept-Language: es-ES, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 vs 2.4.0-ac4/8. Is this normal?
Content-Type: multipart/mixed;
 boundary="------------5DDCF81C3EA58A8EC59C26A6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Este es un mensaje multipartes en formato MIME.
--------------5DDCF81C3EA58A8EC59C26A6
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Compiler: kgcc present in Red Hat 7.0

I hope this to be useful.


-- 
D. Juan Piernas Cánovas
Departamento de Ingeniería y Tecnología de Computadores
Facultad de Informática. Universidad de Murcia
Campus de Espinardo - 30080 Murcia (SPAIN)
Tel.: +34968364633    Fax: +34968364151
email: piernas@ditec.um.es
--------------5DDCF81C3EA58A8EC59C26A6
Content-Type: text/plain; charset=us-ascii;
 name="2.2.17.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.2.17.txt"

[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.55 seconds = 36.06 MB/sec
 Timing buffered disk reads:  64 MB in  6.94 seconds =  9.22 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.44 seconds = 37.21 MB/sec
 Timing buffered disk reads:  64 MB in  6.83 seconds =  9.37 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.48 seconds = 36.78 MB/sec
 Timing buffered disk reads:  64 MB in  6.86 seconds =  9.33 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.56 seconds = 35.96 MB/sec
 Timing buffered disk reads:  64 MB in  6.13 seconds = 10.44 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.58 seconds = 35.75 MB/sec
 Timing buffered disk reads:  64 MB in  6.67 seconds =  9.60 MB/sec

--------------5DDCF81C3EA58A8EC59C26A6
Content-Type: text/plain; charset=us-ascii;
 name="2.4.0-ac8.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.0-ac8.txt"

[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.79 seconds = 33.77 MB/sec
 Timing buffered disk reads:  64 MB in  8.41 seconds =  7.61 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.83 seconds = 33.42 MB/sec
 Timing buffered disk reads:  64 MB in  7.95 seconds =  8.05 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.76 seconds = 34.04 MB/sec
 Timing buffered disk reads:  64 MB in  8.17 seconds =  7.83 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.75 seconds = 34.13 MB/sec
 Timing buffered disk reads:  64 MB in  8.10 seconds =  7.90 MB/sec
[root@localhost /root]# hdparm -tT /dev/hda

/dev/hda:
 Timing buffer-cache reads:   128 MB in  3.77 seconds = 33.95 MB/sec
 Timing buffered disk reads:  64 MB in  7.81 seconds =  8.19 MB/sec

--------------5DDCF81C3EA58A8EC59C26A6
Content-Type: text/plain; charset=us-ascii;
 name="mean.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mean.txt"

2.2.17		36.352 MB/sec	9.592 MB/sec
2.4.0-ac8	33.862 MB/sec	7.916 MB/sec
		-6.8%		-17.4%

--------------5DDCF81C3EA58A8EC59C26A6
Content-Type: text/plain; charset=us-ascii;
 name="2.4.0-ac8.msg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.4.0-ac8.msg"

Linux version 2.4.0-ac8 (root@localhost.localdomain) (gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)) #11 SMP Tue Jan 16 18:04:58 CET 2001
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
APIC turned off by hardware.
mapped APIC to ffffe000 (01089000)
Kernel command line: BOOT_IMAGE=linux-240 ro root=305
Initializing CPU#0
Detected 200.458 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 399.76 BogoMIPS
Memory: 29856k/32768k available (1032k kernel code, 2524k reserved, 422k data, 208k init, 0k highmem)
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
block: queued sectors max/low 19736kB/14802kB, 64 slots per queue
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

--------------5DDCF81C3EA58A8EC59C26A6--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
