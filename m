Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264753AbTFLLdO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264800AbTFLLdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:33:14 -0400
Received: from pointblue.com.pl ([62.89.73.6]:37898 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264753AbTFLLdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:33:07 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: linux-kernel@vger.kernel.org
Subject: via-rhine strange behavior 2.4.21-rc8
Date: Thu, 12 Jun 2003 12:27:02 +0100
User-Agent: KMail/1.5.2
Cc: rl@hellgate.ch
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GOG6+Qamz9aV735"
Message-Id: <200306121227.07122@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_GOG6+Qamz9aV735
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: clearsigned data
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi
I attached dmesg from one of my test toys (servers). I am not able to get=20
via-rhine card to work on it :/

=2D --
Grzegorz Jaskiewicz
K4 Labs
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+6GOKqu082fCQYIgRArZiAJ4qFiSkE/Ds1Ul0SmIehx5jABOY8QCgggsy
S5FW557PJ4iDfJfukOCpzW8=3D
=3DHE/B
=2D----END PGP SIGNATURE-----

--Boundary-00=_GOG6+Qamz9aV735
Content-Type: text/plain;
  charset="us-ascii";
  name="dmesg.via.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="dmesg.via.txt"

Linux version 2.4.21-rc8 (root@debian) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 SMP Thu Jun 12 00:17:38 BST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000dc000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fef0000 (usable)
 BIOS-e820: 000000001fef0000 - 000000001feff000 (ACPI data)
 BIOS-e820: 000000001feff000 - 000000001ff00000 (ACPI NVS)
 BIOS-e820: 000000001ff00000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
510MB LOWMEM available.
On node 0 totalpages: 130800
zone(0): 4096 pages.
zone(1): 126704 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=308
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 994.465 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1985.74 BogoMIPS
Memory: 514376k/523200k available (1545k kernel code, 8436k reserved, 464k data, 296k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 0a
per-CPU timeslice cutoff: 731.65 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 994.5050 MHz.
..... host bus clock speed is 132.6006 MHz.
cpu: 0, clocks: 1326006, slice: 663003
CPU0<T0:1326000,T1:662992,D:5,S:663003,C:1326006>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd96e, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801AA PCI Bridge
PCI: Using IRQ router PIIX [8086/2410] at 00:1f.0
PCI: Device 01:38 not found by BIOS
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
intelfb: Framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G chipsets
intelfb: Version 0.7.5, written by David Dawes <dawes@tungstengraphics.com>
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH: IDE controller at PCI slot 00:1f.1
ICH: chipset revision 2
ICH: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2000-0x2007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x2008-0x200f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L080AVVA07-0, ATA DISK drive
blk: queue c0397920, I/O limit 4095Mb (mask 0xffffffff)
hdc: _NEC DVD_RW ND-1300A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=10011/255/63, UDMA(66)
hdc: attached ide-cdrom driver.
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 296k freed
Adding Swap: 297160k swap-space (priority -1)
8139too Fast Ethernet driver 0.9.26
via-rhine.c:v1.10-LK1.1.17  March-1-2003  Written by Donald Becker
  http://www.scyld.com/network/via-rhine.html
PCI: Found IRQ 5 for device 01:07.0
PCI: Sharing IRQ 5 with 00:1f.3
PCI: Sharing IRQ 5 with 00:1f.5
IRQ routing conflict for 01:07.0, have irq 4, want irq 5
Insufficient PCI resources, aborting

--Boundary-00=_GOG6+Qamz9aV735--

