Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRDDSoE>; Wed, 4 Apr 2001 14:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130471AbRDDSnz>; Wed, 4 Apr 2001 14:43:55 -0400
Received: from dobit2.rug.ac.be ([157.193.42.8]:7917 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S130253AbRDDSnt>;
	Wed, 4 Apr 2001 14:43:49 -0400
Date: Wed, 4 Apr 2001 20:43:03 +0200 (MET DST)
From: Frank Cornelis <Frank.Cornelis@rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@rug.ac.be
Subject: linux 2.4.3 crashed my hard disk
Message-ID: <Pine.GSO.4.10.10104042028270.13922-100000@eduserv2.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

After I did put in /etc/sysconfig/harddisks 
	USE_DMA=1
my system did crash very badly, I guess after my hard disks did wake up
again. For I while I though I'd lose some sectors because of this, I had
to re-install my RedHat 7.0, had a not so productive day :) But, hard
disks are OK now.
I thought I should report this.
Below there is a copy of my dmesg log.

BTW: my motherboard runs at 112 Mhz, overclocked, was 100 Mhz.
Been running this configuration over more than 2 years now without such
major problems.
Could this be the cause?

Frank.

Linux version 2.4.3 (root@bluewall) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #16 Sun Apr 1 18:24:33 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Scan SMP from c009fc00 for 4096 bytes.
On node 0 totalpages: 32752
zone(0): 4096 pages.
zone(1): 28656 pages.
zone(2): 0 pages.
mapped APIC to ffffe000 (01222000)
Kernel command line: auto BOOT_IMAGE=Linux ro root=303 BOOT_FILE=/boot/bzImage idebus=66
ide_setup: idebus=66
Initializing CPU#0
Detected 392.565 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 783.15 BogoMIPS
Memory: 126136k/131008k available (1327k kernel code, 4484k reserved, 479k data, 240k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
VFS: Diskquotas version dquot_6.4.0 initialized
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 01
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.08 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
parport0: PC-style at 0x378 [PCSPP(,...)]
parport0: irq 7 detected
rivafb: RIVA MTRR set to ON
Console: switching to colour frame buffer device 80x30
rivafb: PCI nVidia NV4 framebuffer ver 0.9.2a (RIVA-VTNT2, 32MB @ 0xD4000000)
pty: 256 Unix98 ptys configured
lp0: using parport0 (polling).
block: queued sectors max/low 83690kB/27896kB, 256 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 66MHz system bus speed for PIO modes
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: QUANTUM FIREBALL EX6.4A, ATA DISK drive
hdb: ST38421A, ATA DISK drive
hdc: QUANTUM FIREBALL ST2.1A, ATA DISK drive
hdd: IDE/ATAPI CD-ROM 36X, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/418KiB Cache, CHS=784/255/63, UDMA(33)
hdb: 16498944 sectors (8447 MB) w/256KiB Cache, CHS=16368/16/63, UDMA(33)
hdc: 4124736 sectors (2112 MB) w/81KiB Cache, CHS=4092/16/63, UDMA(33)
hdd: ATAPI 16X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 hda3
 hdb: hdb1 hdb2 hdb3
 hdc: [PTBL] [1023/64/63] hdc1 hdc4
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
NTFS version 000607
Serial driver version 5.05 (2000-12-13) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:09.0
PCI: The same IRQ used for device 00:07.2
eth0: Compex RL2000 found at 0xe400, IRQ 10, 00:80:48:C4:5A:58.
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 94M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 32M @ 0xd0000000
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 17:26:04 Apr  1 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 10 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 10
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
IPv4 over IPv4 tunneling driver
IP-Config: Incomplete network configuration information.
ip_conntrack (1023 buckets, 8184 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: Linux IPX 0.46 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
IPX Portions Copyright (c) 2000, 2001 Conectiva, Inc.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 240k freed
Adding Swap: 56216k swap-space (priority -1)
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: irq timeout: error=0x40 { UncorrectableError }, LBAsect=10371801, sector=2885472
end_request: I/O error, dev 03:03 (hda), sector 2885472
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: irq timeout: error=0x40 { UncorrectableError }, LBAsect=10371801, sector=2885480
end_request: I/O error, dev 03:03 (hda), sector 2885480
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: irq timeout: error=0x40 { UncorrectableError }, LBAsect=10371801, sector=2885488
end_request: I/O error, dev 03:03 (hda), sector 2885488
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: irq timeout: error=0x40 { UncorrectableError }, LBAsect=10371801, sector=2885496
end_request: I/O error, dev 03:03 (hda), sector 2885496
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: irq timeout: error=0x40 { UncorrectableError }, LBAsect=10371801, sector=2885504
end_request: I/O error, dev 03:03 (hda), sector 2885504
hda: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hda: irq timeout: status=0xd1 { Busy }
hda: DMA disabled
hdb: DMA disabled
ide0: reset: success
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=10371802, sector=2885512
end_request: I/O error, dev 03:03 (hda), sector 2885512
hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
hda: read_intr: error=0x40 { UncorrectableError }, LBAsect=10371802, sector=2885512
end_request: I/O error, dev 03:03 (hda), sector 2885512

