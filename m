Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTG1Lpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 07:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbTG1Lpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 07:45:43 -0400
Received: from [213.69.232.58] ([213.69.232.58]:39179 "HELO schottelius.org")
	by vger.kernel.org with SMTP id S262254AbTG1LpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 07:45:16 -0400
Date: Mon, 28 Jul 2003 13:59:02 +0200
From: Nico Schottelius <nico-kernel@schottelius.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: bug in 2.6.0test2
Message-ID: <20030728115902.GA18993@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.6.0-test2
X-Free86: doesn't compile currently
X-Replacement: please tell me some (working)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again!

When trying to boot from a cryptoloop we get the attached error.
Details:
   modules loop,cryptoloop,aes (in this order) are loaded with insmod
   (from initrd)
   then mounting proc

Any suggestions / solutions ?

Nico

ps: please cc me and scholz AT wdt.de

--=20
echo God bless America | sed 's/.*\(A.*$\)/Why \1?/'
pgp: new id: 0x8D0E27A4 | ftp.schottelius.org/pub/familiy/nico/pgp-key.new

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=BASTIAN-LOG
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.0-test2 (root@debian.dummy) (gcc-Version 3.3.1 20030722 (=
Debian prerelease)) #3 Mon Jul 28 13:50:46 CEST 2003

Video mode to be used for restore is 317

BIOS-provided physical RAM map:

 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)

 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)

 BIOS-e820: 0000000000100000 - 000000000ffdb000 (usable)

 BIOS-e820: 000000000ffdb000 - 0000000010000000 (reserved)

 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)

 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)

255MB LOWMEM available.

On node 0 totalpages: 65499

  DMA zone: 4096 pages, LIFO batch:1

  Normal zone: 61403 pages, LIFO batch:14

  HighMem zone: 0 pages, LIFO batch:1

ACPI: RSDP (v000 DELL                       ) @ 0x000f4040

ACPI: RSDT (v001 DELL    CPi R   10194.01308) @ 0x0fff0000

ACPI: FADT (v001 DELL    CPi R   10194.01308) @ 0x0fff0400

ACPI: DSDT (v001 INT430 SYSFexxx 00000.04097) @ 0x00000000

ACPI: BIOS passes blacklist

Building zonelist for node : 0

Kernel command line: BOOT_IMAGE=3D2.6.0-test2 ro root=3D700 console=3DttyS0=
,9600 console=3Dtty0

Initializing CPU#0

PID hash table entries: 1024 (order 10: 8192 bytes)

Detected 498.550 MHz processor.

Console: colour dummy device 80x25

Calibrating delay loop... 985.08 BogoMIPS

Memory: 254084k/261996k available (2409k kernel code, 7212k reserved, 726k =
data, 136k init, 0k highmem)

Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)

Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)

Mount-cache hash table entries: 512 (order: 0, 4096 bytes)

-> /dev

-> /dev/console

-> /root

CPU: L1 I cache: 16K, L1 D cache: 16K

CPU: L2 cache: 256K

Intel machine check architecture supported.

Intel machine check reporting enabled on CPU#0.

CPU: Intel Pentium III (Coppermine) stepping 03

Enabling fast FPU save and restore... done.

Enabling unmasked SIMD FPU exception support... done.

Checking 'hlt' instruction... OK.

POSIX conformance testing by UNIFIX

Initializing RT netlink socket

PCI: PCI BIOS revision 2.10 entry at 0xfc0ae, last bus=3D1

PCI: Using configuration type 1

mtrr: v2.0 (20020519)

BIO: pool of 256 setup, 15Kb (60 bytes/bio)

biovec pool[0]:   1 bvecs: 256 entries (12 bytes)

biovec pool[1]:   4 bvecs: 256 entries (48 bytes)

biovec pool[2]:  16 bvecs: 256 entries (192 bytes)

biovec pool[3]:  64 bvecs: 256 entries (768 bytes)

biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)

biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)

ACPI: Subsystem revision 20030714

ACPI: Interpreter enabled

ACPI: Using PIC for interrupt routing

ACPI: PCI Root Bridge [PCI0] (00:00)

PCI: Probing PCI hardware (bus 00)

ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)

ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15, disabled)

ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)

ACPI: Power Resource [PADA] (on)

Linux Plug and Play Support v0.96 (c) Adam Belay

ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10

PCI: Using ACPI for IRQ routing

PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'

vesafb: framebuffer at 0xfd000000, mapped to 0xd0807000, size 8128k

vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D4

vesafb: protected mode interface info at c000:5044

vesafb: scrolling: redraw

vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0

fb0: VESA VGA frame buffer device

Console: switching to colour frame buffer device 128x48

pty: 256 Unix98 ptys configured

Enabling SEP on CPU 0

udf: registering filesystem

SGI XFS for Linux 2.6.0-test2 with ACLs, no debug enabled

Initializing Cryptographic API

Limiting direct PCI/PCI transfers.

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled

ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A

ttyS2 at I/O 0x3e8 (irq =3D 4) is a 16550A

RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx

PIIX4: IDE controller at PCI slot 0000:00:07.1

PIIX4: chipset revision 1

PIIX4: not 100% native mode: will probe irqs later

    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio

    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:pio, hdd:pio

hda: FUJITSU MHR2030AT, ATA DISK drive

Using anticipatory scheduling elevator

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14

ide2: I/O resource 0x3EE-0x3EE not free.

ide2: ports already in use, skipping probe

hda: max request size: 1024KiB

hda: host protected area =3D> 1

hda: 58605120 sectors (30006 MB) w/2048KiB Cache, CHS=3D3648/255/63, UDMA(3=
3)

 hda: hda1 hda2 hda3 hda4

Console: switching to colour frame buffer device 128x48

mice: PS/2 mouse device common for all mice

input: PS/2 Generic Mouse on isa0060/serio1

serio: i8042 AUX port at 0x60,0x64 irq 12

input: AT Set 2 keyboard on isa0060/serio0

serio: i8042 KBD port at 0x60,0x64 irq 1

Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun 09 12:01:18=
 2003 UTC).

es1968: clocking to 48000

ALSA device list:

  #0: ESS ES1978 (Maestro 2E) at 0xd800, irq 5

NET4: Linux TCP/IP 1.0 for NET4.0

IP: routing cache hash table of 2048 buckets, 16Kbytes

TCP: Hash tables configured (established 16384 bind 32768)

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

IPv6 v0.8 for NET4.0

IPv6 over IPv4 tunneling driver

BIOS EDD facility v0.09 2003-Jan-22, 1 devices found

RAMDISK: Compressed image found at block 0

Freeing initrd memory: 1158k freed

EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended

VFS: Mounted root (ext2 filesystem).

loop: loaded (max 8 devices)

bio too big device loop0 (2 > 0)

EXT2-fs: unable to read superblock

bio too big device loop0 (4 > 0)

bio too big device loop0 (4 > 0)

bio too big device loop0 (4 > 0)

UDF-fs: No partition found (1)

------------[ cut here ]------------

kernel BUG at drivers/block/ll_rw_blk.c:2120!

invalid operand: 0000 [#1]

CPU:    0

EIP:    0060:[<c0263797>]    Not tainted

EFLAGS: 00010246

EIP is at submit_bio+0x67/0x80

eax: 00000000   ebx: 00000000   ecx: 00000000   edx: cffb5aa0

esi: 00000000   edi: 00002a05   ebp: 00000200   esp: cff91c20

ds: 007b   es: 007b   ss: 0068

Process swapper (pid: 1, threadinfo=3Dcff90000 task=3Dc129b840)

Stack: 00002a05 cffb5aa0 c0203db4 00000000 cffb5aa0 00001000 00000000 00000=
000=20

       00000000 00000000 00000000 000000d0 00000000 00000000 cf91fd80 c126d=
248=20

       c0202cb8 cf928d6c 00000000 000000d0 c0441474 00000000 cff90000 00000=
000=20

Call Trace:

 [<c0203db4>] pagebuf_iorequest+0x3d4/0x400

 [<c0202cb8>] _pagebuf_lookup_pages+0x398/0x3e0

 [<c0203858>] pagebuf_iostart+0x88/0xc0

 [<c02030b2>] pagebuf_get+0x142/0x150

 [<c01ef2a3>] xfs_readsb+0x53/0x240

 [<c01f834c>] xfs_mount+0x29c/0x600

 [<c020dd13>] vfs_mount+0x43/0x50

 [<c020daff>] linvfs_fill_super+0xaf/0x240

 [<c0219d07>] snprintf+0x27/0x30

 [<c0180c7f>] disk_name+0xaf/0xc0

 [<c0157c25>] sb_set_blocksize+0x25/0x60

 [<c0157604>] get_sb_bdev+0x124/0x160

 [<c020dcbf>] linvfs_get_sb+0x2f/0x40

 [<c020da50>] linvfs_fill_super+0x0/0x240

 [<c015786f>] do_kern_mount+0x5f/0xe0

 [<c016cfc8>] do_add_mount+0x78/0x160

 [<c016d2d4>] do_mount+0x134/0x180

 [<c021aa00>] __copy_from_user_ll+0x70/0x80

 [<c016d190>] copy_mount_options+0xe0/0xf0

 [<c016d69f>] sys_mount+0xbf/0x140

 [<c0412bef>] do_mount_root+0x2f/0xa0

 [<c0412cb4>] mount_block_root+0x54/0x130

 [<c010ae4b>] syscall_call+0x7/0xb

 [<c0412f27>] mount_root+0x47/0x50

 [<c0413ca5>] handle_initrd+0x1f5/0x300

 [<c0413e33>] initrd_load+0x83/0x90

 [<c0412f62>] prepare_namespace+0x32/0x110

 [<c01050a4>] init+0x34/0x1c0

 [<c0105070>] init+0x0/0x1c0

 [<c0108d75>] kernel_thread_helper+0x5/0x10



Code: 0f 0b 48 08 78 96 37 c0 eb aa eb 0d 90 90 90 90 90 90 90 90=20

 <0>Kernel panic: Attempted to kill init!


--xHFwDpU9dbj6ez1V--

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/JRAFtnlUggLJsX0RAt0LAJ9zKvAvIAjkCqSoF2ZZth/XRBnEnwCdEJHV
3wwGLT0AgDwp+4zHs3y4T4o=
=PyZZ
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
