Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTDIW3C (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 18:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263966AbTDIW3C (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 18:29:02 -0400
Received: from limdns2.unilim.fr ([164.81.1.5]:50379 "EHLO limdns2.unilim.fr")
	by vger.kernel.org with ESMTP id S263965AbTDIW25 (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 18:28:57 -0400
Date: Thu, 10 Apr 2003 00:40:32 +0200 (MEST)
From: Hubert Mercier - Faculte des Sciences <mercier@unilim.fr>
To: linux-kernel@vger.kernel.org
Subject: keyboard problem
Message-ID: <Pine.OSF.4.43.0304100025550.94388-100000@limrec.unilim.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-ECS-Serveur-Anti-Virus: =?ISO-8859-1?Q?=20Trouv=E9?= comme  =?ISO-8859-1?Q?=20n'=E9tant?= pas  =?ISO-8859-1?Q?=20i?=
	=?ISO-8859-1?Q?nfect=E9?=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I try to compile the linux kernel 2.4.20 on the gentoo 1.4rc3 and i can't
get the ps2 keyboard working :

dmesg gives me the following (sorry, full dump follows ;-).

I tried several configs, with and without APIC (i found a few messages on
the subject), but i really can't get it working. I got into the box
activating sshd and logging from network, but this is not very pratical
;-)
The target machine is a Asus Terminator P4 533, specifications are
available here : http://www.asus.com/prog/spec.asp?m=Terminator%20P4%20533
Chipset is a SIS651.

Does someone have a clue ?

Thanks in advance !


 dmesg dump :
--------------

Linux version 2.4.20-gentoo-r2 (root@neskaya.limoges.net) (gcc version
3.2.1 20021207 (Gentoo Linux 3.2.1-20021207)) #6 Thu Ap
r 10 02:13:30 CEST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fbfc000 (usable)
 BIOS-e820: 000000000fbfc000 - 000000000fbff000 (ACPI data)
 BIOS-e820: 000000000fbff000 - 000000000fc00000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
251MB LOWMEM available.
On node 0 totalpages: 64508
zone(0): 4096 pages.
zone(1): 60412 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda1
Found and enabled local APIC!
Initializing CPU#0
Detected 1700.146 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3394.76 BogoMIPS
Memory: 252476k/258032k available (1531k kernel code, 5168k reserved, 498k
data, 108k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Celeron(R) CPU 1.70GHz stepping 03
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1700.1706 MHz.
..... host bus clock speed is 100.0099 MHz.
cpu: 0, clocks: 1000099, slice: 500049
CPU0<T0:1000096,T1:500032,D:15,S:500049,C:1000099>
PCI: PCI BIOS revision 2.10 entry at 0xf1150, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router default [1039/0962] at 00:02.0
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
SIS5513: IDE controller on PCI bus 00 dev 15
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS5513
    ide0: BM-DMA at 0xa400-0xa407, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa408-0xa40f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: ST360015A, ATA DISK drive
hdc: HL-DT-STDVD-ROM GDR8161B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=7297/255/63
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p4 < p5 p6 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0x8800, IRQ 3, 00:e0:18:bc:3b:16.
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 199M
agpgart: Unsupported SiS chipset (device id: 0651), you might want to try
agp_try_unsupported=1.
agpgart: no supported devices found.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 108k freed
Adding Swap: 530104k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
reiserfs: checking transaction log (device 03:06) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
eth0: Media Link On 100mbps full-duplex





================================================================================
 Hubert MERCIER
 Faculte des Sciences
 83, Rue d'Isle
 87000 Limoges - France

 tel : 05.55.43.69.81
 fax : 05.55.43.69.77

 e-mail : mercier@unilim.fr
================================================================================

