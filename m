Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129414AbQLFRUg>; Wed, 6 Dec 2000 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129518AbQLFRU1>; Wed, 6 Dec 2000 12:20:27 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:55893 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S129414AbQLFRUP>;
	Wed, 6 Dec 2000 12:20:15 -0500
Message-ID: <3A2E6E2B.52406DE4@student.ethz.ch>
Date: Wed, 06 Dec 2000 17:49:47 +0100
From: Giacomo Catenazzi <cate@student.ethz.ch>
X-Mailer: Mozilla 4.73 [en] (X11; U; SunOS 5.6 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: test12-pre4: spurious 8259A interrupt: IRQ7.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2000 16:49:48.0318 (UTC) FILETIME=[8B53E3E0:01C05FA4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On my box, with heavy load I saw:
spurious 8259A interrupt: IRQ7.
Newer seen this message before.

Linux (2.4.0.11.4) or my old slow box ?


	giacomo


My dmesg

BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000020000 @ 00000000000e0000 (reserved)
 BIOS-e820: 0000000002f00000 @ 0000000000100000 (usable)
 BIOS-e820: 0000000000020000 @ 00000000fffe0000 (reserved)
 BIOS-e820: 0000000000000000 @ 0000000000000000 type 0
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 12288
zone(0): 4096 pages.
zone(1): 8192 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (010cd000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=301
BOOT_FILE=/vmlinuz ro pan
ic=20 reboot=warm
Initializing CPU#0
Detected 199.434 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 398.13 BogoMIPS
Memory: 46504k/49152k available (955k kernel code, 2260k reserved, 62k
data, 192
k init, 0k highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
CPU: Before vendor init, caps: 0000f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 8K, L1 D cache: 8K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0000f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0000f9ff 00000000 00000000 00000000
CPU: Common caps: 0000f9ff 00000000 00000000 00000000
CPU: Intel Pentium Pro stepping 07
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
Activating ISA DMA hang workarounds.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd v1.8
matroxfb: Matrox Millennium (PCI) detected
matroxfb: MTRR's turned on
matroxfb: 640x480x8bpp (virtual: 640x3276)
matroxfb: framebuffer at 0x40800000, mapped to 0xc3805000, size 2097152
Console: switching to colour frame buffer device 80x30
fb0: MATROX VGA frame buffer device
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX3: IDE controller on PCI bus 00 dev 39
PIIX3: chipset revision 0
PIIX3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALL SE3.2A, ATA DISK drive
hdc: MATSHITA CR-583, ATAPI CDROM drive
hdd: CD-524E, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 6306048 sectors (3229 MB) w/80KiB Cache, CHS=782/128/63, (U)DMA
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Real Time Clock Driver v1.10d
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 192k freed
Adding Swap: 124988k swap-space (priority -1)
inserting floppy driver for 2.4.0-test12
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
hdc: ATAPI 8X CD-ROM drive, 128kB Cache, DMA
Uniform CD-ROM driver Revision: 3.11
hdd: ATAPI 24X CD-ROM drive, 128kB Cache, DMA
SCSI subsystem driver Revision: 1.00
0x378: FIFO is 16 bytes
0x378: writeIntrThreshold is 8
0x378: readIntrThreshold is 8
0x378: PWord is 8 bits
0x378: Interrupts are ISA-Pulses
0x378: ECP port cfgA=0x14 cfgB=0x7b
0x378: ECP settings irq=5 dma=3
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,COMPAT,ECP]
parport0: irq 5 detected
parport0: Found 1 daisy-chained devices
parport0: No more nibble data (1 bytes)
parport0: device reported incorrect length field (61, should be 62)
parport0 (addr 0): SCSI adapter, IMG VP1
imm: Version 2.04 (for Linux 2.4.0)
imm: Found device at ID 6, Attempting to use EPP 32 bit
imm: Found device at ID 6, Attempting to use PS/2
imm: Communication established at 0x378 with ID 6 using PS/2
scsi0 : Iomega VPI2 (imm) interface
  Vendor: IOMEGA    Model: ZIP 250           Rev: H.41
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 6, lun 0
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 08 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
 unable to read partition table
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 08 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
cdrom: open failed.
VFS: Disk change detected on device ide1(22,64)
P6 Microcode Update Driver v1.07
microcode: CPU0 updated from revision 197 to 198, date=12101996
microcode: freed 2048 bytes
Device not ready.  Make sure there is a disc in the drive.
VFS: Disk change detected on device 08:00
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 08 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 /dev/scsi/host0/bus0/target6/lun0: I/O error: dev 08:00, sector 0
VFS: Disk change detected on device 08:00
SCSI device sda: 196608 512-byte hdwr sectors (101 MB)
sda: Write Protect is off
 /dev/scsi/host0/bus0/target6/lun0: p4
spurious 8259A interrupt: IRQ7.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
