Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281887AbRLHPsn>; Sat, 8 Dec 2001 10:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281932AbRLHPsd>; Sat, 8 Dec 2001 10:48:33 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:58347 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S281887AbRLHPs1>; Sat, 8 Dec 2001 10:48:27 -0500
Message-ID: <3C1235C4.BC20AC8E@wanadoo.fr>
Date: Sat, 08 Dec 2001 16:46:12 +0100
From: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Organization: Home PC
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.1-pre7+devfs-v203 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.1-pre7 ide-cd module
Content-Type: multipart/mixed;
 boundary="------------AC8171F0F1C62D980C8A2202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------AC8171F0F1C62D980C8A2202
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Attached is dmesg with 2.5.1-pre7 + devfs-patch-v203.

The first and second manual loading of the ide-cd module give something
different.

#modprobe ide-cd ; rmmod ide-cd ; modprobe ide-cd

hdc: ATAPI CD-ROM drive, 0kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA

Why ?

Pierre
-- 
------------------------------------------------
 Pierre Rousselet <pierre.rousselet@wanadoo.fr>
------------------------------------------------
--------------AC8171F0F1C62D980C8A2202
Content-Type: text/plain; charset=iso-8859-1;
 name="MESS"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="MESS"

Linux version 2.5.1-pre7+devfs-v203 (root@milou) (gcc version 2.95.3 20010315 (release)) #1 sam déc 8 16:20:55 CET 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
On node 0 totalpages: 65536
zone(0): 4096 pages.
zone(1): 61440 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: vga=4 root=/dev/discs/disc0/part2 ro mem=262144K
Initializing CPU#0
Detected 670.105 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 1336.93 BogoMIPS
Memory: 256344k/262144k available (782k kernel code, 5412k reserved, 242k data, 72k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000040
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 670.0819 MHz.
..... host bus clock speed is 103.0894 MHz.
cpu: 0, clocks: 1030894, slice: 515447
CPU0<T0:1030880,T1:515424,D:9,S:515447,C:1030894>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.15)
Starting kswapd
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec: init pool 0, 1 entries, 12 bytes
biovec: init pool 1, 4 entries, 48 bytes
biovec: init pool 2, 16 entries, 192 bytes
biovec: init pool 3, 64 entries, 768 bytes
biovec: init pool 4, 128 entries, 1536 bytes
biovec: init pool 5, 256 entries, 3072 bytes
devfs: v1.5 (20011204) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x1
block: 256 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.32
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
HPT366: onboard version of chipset, pin1=1 pin2=2
HPT366: IDE controller on PCI slot 00:13.0
PCI: Found IRQ 11 for device 00:13.0
PCI: Sharing IRQ 11 with 00:13.1
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xd400-0xd407, BIOS settings: hde:pio, hdf:pio
HPT366: IDE controller on PCI slot 00:13.1
PCI: Found IRQ 11 for device 00:13.1
PCI: Sharing IRQ 11 with 00:13.0
HPT366: chipset revision 1
HPT366: not 100% native mode: will probe irqs later
    ide3: BM-DMA at 0xe000-0xe007, BIOS settings: hdg:pio, hdh:pio
hdc: CRD-8240B, ATAPI CD/DVD-ROM drive
hde: ST310212A, ATA DISK drive
hdg: SAMSUNG SV0322A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xcc00-0xcc07,0xd002 on irq 11
ide3 at 0xd800-0xd807,0xdc02 on irq 11
blk: queue c023bc84, I/O limit 4095Mb (mask 0xffffffff)
hde: 20005650 sectors (10243 MB) w/512KiB Cache, CHS=19846/16/63, UDMA(66)
blk: queue c023c004, I/O limit 4095Mb (mask 0xffffffff)
hdg: 6250608 sectors (3200 MB) w/478KiB Cache, CHS=11024/9/63, UDMA(33)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: [PTBL] [1245/255/63] p1 p2 p3 p4
 /dev/ide/host3/bus0/target0/lun0: p1
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 204M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 256M @ 0xc0000000
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 72k freed
Adding Swap: 80316k swap-space (priority -1)
Real Time Clock Driver v1.10e
es1370: version v0.37 time 16:25:02 Dec  8 2001
PCI: Found IRQ 9 for device 00:09.0
PCI: Sharing IRQ 9 with 00:07.2
es1370: found adapter at io 0xc400 irq 9
es1370: features: joystick off, line out, mic impedance 0
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:0d.0
eth0: RealTek RTL-8029 found at 0xc800, IRQ 10, 00:40:05:E4:DB:3F.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
parport0: cpp_daisy: aa5500ff(98)
parport0: assign_addrs: aa5500ff(98)
parport0: Printer, HEWLETT-PACKARD DESKJET 930C
lp0: using parport0 (interrupt-driven).
lp0: compatibility mode
hdc: ATAPI CD-ROM drive, 0kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, DMA

--------------AC8171F0F1C62D980C8A2202--

