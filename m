Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUBYWCw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUBYWCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:02:46 -0500
Received: from ns.schottelius.org ([213.146.113.242]:1152 "HELO
	scice.schottelius.org") by vger.kernel.org with SMTP
	id S261673AbUBYWAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:00:17 -0500
Date: Wed, 25 Feb 2004 23:00:51 +0100
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: nico-kernel@schottelius.org
Subject: another hard disk broken or xfs problems?
Message-ID: <20040225220051.GA187@schottelius.org>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
X-MSMail-Priority: (u_int) -1
X-Mailer: echo $message | gpg -e $sender  -s | netcat mailhost 25
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
Organization: http://nerd-hosting.net/
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

I am now using a brand new 40GB Hitachi hard disk for my notebook and
today I got the first problems:


Starting XFS recovery on filesystem: hda3 (dev: hda3)
Ending XFS recovery on filesystem: hda3 (dev: hda3)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
XFS mounting filesystem hda1
Starting XFS recovery on filesystem: hda1 (dev: hda1)
Ending XFS recovery on filesystem: hda1 (dev: hda1)
XFS mounting filesystem loop0
Starting XFS recovery on filesystem: loop0 (dev: loop0)
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1589 of file fs/xfs/xfs_=
alloc.c.  Caller 0xc0198272
Call Trace: [<c0197151>]  [<c0198272>]  [<c0198272>]  [<c01c7fff>]  [<c01ee=
628>]  [<c01e5286>]  [<c01e5355>]  [<c01e6b04>]  [<c01d24fa>]  [<c01dd2cc>]=
  [<c01e83bd>]  [<c0203c60>]  [<c01d908f>]  [<c01f02c6>]  [<c02048e3>]  [<c=
02046c8>]  [<c0215517>]  [<c0185764>]  [<c015c835>]  [<c015c268>]  [<c02048=
90>]  [<c0204630>]  [<c015c4af>]  [<c0171ee8>]  [<c01721f4>]  [<c0172044>] =
 [<c01725ef>]  [<c010b34b>]=20
Ending XFS recovery on filesystem: loop0 (dev: loop0)
Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1


I got this after a clean shutdown. Just tell me it's an xfs error and my
harddisk is fine...

Nico, who does not want to believe the next hard disk is dieing.

ps: attached full dmesg

--=20
Keep it simple & stupid, use what's available.
pgp: 8D0E E27A          | Nico Schottelius
http://nerd-hosting.net | http://linux.schottelius.org

--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.first.new.error"
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.3 (root@scice) (gcc version 3.3.3 (Debian)) #3 Fri Feb 20=
 20:05:17 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000095c00 (usable)
 BIOS-e820: 0000000000095c00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000016ff0000 (usable)
 BIOS-e820: 0000000016ff0000 - 0000000016ff8000 (ACPI data)
 BIOS-e820: 0000000016ff8000 - 0000000017000000 (ACPI NVS)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
367MB LOWMEM available.
On node 0 totalpages: 94192
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 90096 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fad50
ACPI: RSDT (v001 AMIINT AMIINT09 0x00000011 MSFT 0x00000097) @ 0x16ff0000
ACPI: FADT (v001 AMIINT AMIINT09 0x00000011 MSFT 0x00000097) @ 0x16ff0030
ACPI: DSDT (v001 TM5600    TMx86 0x00001000 MSFT 0x0100000d) @ 0x00000000
Built 1 zonelists
Kernel command line: root=3D/dev/hda3 init=3D/sbin/minit video=3Dsisfb:mode=
:1024x768x16,rate=3D60
sisfb: Options mode:1024x768x16,rate=3D60
sisfb: Invalid option rate=3D60
No local APIC present or hardware disabled
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 599.310 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 369300k/376768k available (2165k kernel code, 6692k reserved, 416k =
data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1101.82 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0084893f 0081813f 00000000 00000000
CPU:     After vendor identify, caps: 0084893f 0081813f 0000000e 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 512K (128 bytes/line)
CPU: Processor revision 1.3.2.1, 600 MHz
CPU: Code Morphing Software revision 4.2.7-8-278
CPU: 20011004 02:04 official release 4.2.7#7
CPU serial number disabled.
CPU:     After all inits, caps: 0080893f 0081813f 0000000e 00000000
CPU: Transmeta(tm) Crusoe(tm) Processor TM5600 stepping 03
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfda61, last bus=3D0
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040116
ACPI: IRQ4 SCI: Edge set to Level Trigger.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 14 15)
ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ACPI: PCI Interrupt Link [LNKP] enabled at IRQ 10
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
sisfb: Video ROM found and mapped to c00c0000
sisfb: Framebuffer at 0xd0000000, mapped to 0xd780a000, size 16384k
sisfb: MMIO at 0xeffc0000, mapped to 0xd880b000, size 256k
sisfb: Memory heap starting at 15360K
sisfb: Using MMIO queue mode
sisfb: Detected SiS301LV video bridge
sisfb: Detected LCD PanelDelayCompensation 4
sisfb: Default mode is 1024x768x16 (60Hz)
sisfb: Initial vbflags 0x4000012
sisfb: Added MTRRs
sisfb: Installed SISFB_GET_INFO ioctl (80046ef8)
sisfb: Installed SISFB_GET_VBRSTATUS ioctl (80046ef9)
sisfb: 2D acceleration is enabled, scrolling mode ypan (auto-max)
fb0: SIS 315PRO frame buffer device, Version 1.6.25
sisfb: (C) 2001-2004 Thomas Winischhofer.
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS with no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
Activating ISA DMA hang workarounds.
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID0]
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Linux agpgart interface v0.100 (c) Dave Jones
[drm] Initialized sis 1.1.0 20030826 on minor 0
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ACPI: No IRQ known for interrupt pin A of device 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:pio
hda: TOSHIBA MK4025GAS, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: QSI CD-RW/DVD-ROM SBW-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=3D65535/16/63, UDMA(100)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 p4
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firmware: 5.8
 Sensor: 29
 new absolute packet format
 Touchpad has extended capability bits
 -> 4 multi-buttons, i.e. besides standard buttons
 -> multifinger detection
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.12 2004-Jan-26, 1 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
ACPI: (supports S0 S1 S3 S4 S5)
XFS mounting filesystem hda3
Starting XFS recovery on filesystem: hda3 (dev: hda3)
Ending XFS recovery on filesystem: hda3 (dev: hda3)
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 156k freed
XFS mounting filesystem hda1
Starting XFS recovery on filesystem: hda1 (dev: hda1)
Ending XFS recovery on filesystem: hda1 (dev: hda1)
XFS mounting filesystem loop0
Starting XFS recovery on filesystem: loop0 (dev: loop0)
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 1589 of file fs/xfs/xfs_=
alloc.c.  Caller 0xc0198272
Call Trace: [<c0197151>]  [<c0198272>]  [<c0198272>]  [<c01c7fff>]  [<c01ee=
628>]  [<c01e5286>]  [<c01e5355>]  [<c01e6b04>]  [<c01d24fa>]  [<c01dd2cc>]=
  [<c01e83bd>]  [<c0203c60>]  [<c01d908f>]  [<c01f02c6>]  [<c02048e3>]  [<c=
02046c8>]  [<c0215517>]  [<c0185764>]  [<c015c835>]  [<c015c268>]  [<c02048=
90>]  [<c0204630>]  [<c015c4af>]  [<c0171ee8>]  [<c01721f4>]  [<c0172044>] =
 [<c01725ef>]  [<c010b34b>]=20
Ending XFS recovery on filesystem: loop0 (dev: loop0)
Adding 192772k swap on /dev/discs/disc0/part2.  Priority:-1 extents:1
8139too Fast Ethernet driver 0.9.27
eth0: RealTek RTL8139 at 0xd886ee00, 00:0a:e6:ba:f6:c2, IRQ 5
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
eth0: link down
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0379780(lo)
IPv6 over IPv4 tunneling driver
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: no IPv6 routers present
eth0: link up, 100Mbps, full-duplex, lpa 0x41E1
eth0: no IPv6 routers present

--EVF5PPMfhYS0aIcm--

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPRsTzGnTqo0OJ6QRAnVFAKCbZgitHcXdYBqcJy5WaXN+YJCXGACgj+3n
OplcFxjrrPbzAslauzpdLhc=
=py4R
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
