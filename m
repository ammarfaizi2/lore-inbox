Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261858AbSJNHbo>; Mon, 14 Oct 2002 03:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261860AbSJNHbo>; Mon, 14 Oct 2002 03:31:44 -0400
Received: from ktf.dtp.fmph.uniba.sk ([158.195.17.105]:3520 "EHLO
	sophia.dtp.fmph.uniba.sk") by vger.kernel.org with ESMTP
	id <S261858AbSJNHbm>; Mon, 14 Oct 2002 03:31:42 -0400
Date: Mon, 14 Oct 2002 08:28:28 +0200
From: Maros RAJNOCH /HiaeR Silvanna/ <rajnoch@sophia.dtp.fmph.uniba.sk>
To: linux-kernel@vger.kernel.org
Message-ID: <20021014082828.B31820@sophia.dtp.fmph.uniba.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Unmounting file systems: Kernel BUG at page_alloc.c:90!
invalid operand: 0000
CPU:    0
EIP:    0010:[<co12d0ea>]
EFLAGS: 00010286
eax: 0000001f   ebx: 00000000   ecx: 00000001   edx: c02575a4
esi: 00000000   edi: c1452c7c   ebp: 00000000   esp: d1b51e8c
ds: 0018   es: 0018   ss: 0018
Process umount (pid:11412, stackpage=d1b51000)
Stack: c020ea7b c020ec89 0000005a c1452c7c c0135b93 c1452c7c 00000000 c1452c7c
       c1452c7c c1452c7c c1452c7c 00000000 c0124d6c c1452c7c 00000000 c0113c31
       d1b51ef8 c01356e1 d3895f60 d1b51ef0 d1244c28 00000000 00000000 c0124e1b
Call Trace: [<c020ea7b>] [<c020ec89>] [<c0135b93>] [<c0124d6c>] [<c0113c31>]
            [<c01356e1>] [<c0124e1b>] [<c01471d7>] [<c01472f8>] [<c0138fa9>]
            [<c01393b1>] [<c013949a>] [<c010901b>] [<c010002b>]

Code: 0f 0b 83 c4 0c 8b 47 18 83 e0 20 74 16 6a 5c 68 98 ec 20 c0


Linux version 2.4.2-2 (root@porky.devel.redhat.com) (gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-79)) #1 Sun Apr 8 20:41:30 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
 BIOS-e820: 0000000000000400 @ 000000000009fc00 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
 BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
 BIOS-e820: 0000000013ef0000 @ 0000000000100000 (usable)
 BIOS-e820: 000000000000d000 @ 0000000013ff3000 (ACPI data)
 BIOS-e820: 0000000000003000 @ 0000000013ff0000 (ACPI NVS)
On node 0 totalpages: 81904
zone(0): 4096 pages.
zone DMA has max 32 cached pages.
zone(1): 77808 pages.
zone Normal has max 607 cached pages.
zone(2): 0 pages.
zone HighMem has max 1 cached pages.
Kernel command line: auto BOOT_IMAGE=Linux ro root=306 BOOT_FILE=/boot/vmlinuz-2.4.2-2 video=vesa:mtrr
Initializing CPU#0
Detected 374.843 MHz processor.
Console: colour dummy device 80x25
Calibrating delay loop... 748.74 BogoMIPS
Memory: 319732k/327616k available (1365k kernel code, 7496k reserved, 92k data, 236k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
VFS: Diskquotas version dquot_6.5.0 initialized
CPU: Before vendor init, caps: 0183f9ff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183f9ff 00000000 00000000 00000000
CPU: After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU: Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 00
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 5 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
Starting kswapd v1.8
vesafb: framebuffer at 0xe6000000, mapped to 0xd4800000, size 7936k
vesafb: mode is 1024x768x16, linelength=2048, pages=3
vesafb: protected mode interface info at c000:0444
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
pty: 256 Unix98 ptys configured
block: queued sectors max/low 211784kB/80712kB, 640 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC26400B, ATA DISK drive
hdc: CD-532E-B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 12594960 sectors (6449 MB) w/512KiB Cache, CHS=784/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda4 < hda5 hda6 hda7 hda8 hda9 >
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS MULTIPORT SHARE_IRQ SERIAL_PCI ISAPNP enabled
Real Time Clock Driver v1.10d
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 236k freed
Adding Swap: 104380k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 20:53:29 Apr  8 2001
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:07.2
PCI: The same IRQ used for device 00:09.0
usb-uhci.c: USB UHCI at I/O 0x9000, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9qmQL30EmOIsPLkURAlGXAKDcZRygKoTfuoXxzKgha90ElDz17ACgxVVo
HweMi/qiaope7roWy0bl7ps=
=i771
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
