Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267125AbTA0FX6>; Mon, 27 Jan 2003 00:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbTA0FX5>; Mon, 27 Jan 2003 00:23:57 -0500
Received: from spectre.bentonrea.com ([216.7.40.37]:15364 "EHLO
	spectre.bentonrea.com") by vger.kernel.org with ESMTP
	id <S267125AbTA0FXw>; Mon, 27 Jan 2003 00:23:52 -0500
Message-ID: <000e01c2c5c5$fc3731a0$0101a8c0@localdomain>
From: "Enlight" <enlight@bentonrea.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem - See attached dmesg dump
Date: Sun, 26 Jan 2003 21:36:04 -0800
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000B_01C2C582.ED73BA00"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C2C582.ED73BA00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

To who can help,

While running make to build xfce3.8.18 I get an internal gcc error
segmentation fault.  Also got similar error running rpmdrake.  Needless to
say I can't finish the build.

Attached is a file with the error messages and a lot of info on my system.
The cdrom fail to open is another issue that I need to investigate.  I don't
think it is related, but who knows.

Please cc personally to me, I am not subscribed to mailing list. If it is my
hardware, such as memory, please suggest method to test to verify.

Thanks,

Jerry

------=_NextPart_000_000B_01C2C582.ED73BA00
Content-Type: text/plain;
	name="savebug.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="savebug.txt"

Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc version =
3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05 CEST 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e2f9b - 00000000000ec4db (reserved)
 BIOS-e820: 00000000000f1c2a - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000004000000 (usable)
 BIOS-e820: 00000000ffff1c2a - 0000000100000000 (reserved)
64MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 16384
zone(0): 4096 pages.
zone(1): 12288 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=3Dlinux ro root=3D301 devfs=3Dmount
No local APIC present or hardware disabled
Initializing CPU#0
Detected 166.196 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 331.77 BogoMIPS
Memory: 62268k/65536k available (1176k kernel code, 2880k reserved, 444k =
data, 136k init, 0k highmem)
Dentry cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 000001bf 00000000 00000000, vendor =3D 0
Intel Pentium with F0 0F bug - workaround enabled.
CPU: After vendor init, caps: 000001bf 00000000 00000000 00000000
CPU:     After generic, caps: 000001bf 00000000 00000000 00000000
CPU:             Common caps: 000001bf 00000000 00000000 00000000
CPU: Intel Pentium 75 - 200 stepping 0c
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: none
PCI: PCI BIOS revision 2.10 entry at 0xf85ad, last bus=3D0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: Card 'ESS ES1868 Plug and Play AudioDrive'
isapnp: 1 Plug & Play card detected total
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.1 Flags 0x03 (Driver version 1.16)
Starting kswapd
VFS: Diskquotas version dquot_6.5.0 initialized
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with HUB-6 MANY_PORTS MULTIPORT =
SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16550A
ttyS01 at 0x02f8 (irq =3D 3) is a 16550A
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx
PIIX: IDE controller on PCI bus 00 dev 78
PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
PIIX: neither IDE port enabled (BIOS)
PIIX: IDE controller on PCI bus 00 dev 79
PIIX: chipset revision 2
PIIX: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfcf0-0xfcf7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfcf8-0xfcff, BIOS settings: hdc:DMA, hdd:pio
hda: WDC AC22100H, ATA DISK drive
hdc: E285X, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: Disabling (U)DMA for WDC AC22100H
hda: 4124736 sectors (2112 MB) w/128KiB Cache, CHS=3D1023/64/63
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 < p5 p6 >
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
md: md driver 0.90.0 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 8192)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 119k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Mounted devfs on /dev
Freeing unused kernel memory: 136k freed
Real Time Clock Driver v1.10e
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,1), internal journal
Adding Swap: 215672k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,6), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 80 29 62 af 0d
eth0: NE2000 found at 0x300, using IRQ 10.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
inserting floppy driver for 2.4.19-16mdk
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
hdc: ATAPI 8X CD-ROM drive, 240kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
SCSI subsystem driver Revision: 1.00
udf: registering filesystem
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
end_request: I/O error, dev 02:00 (floppy), sector 0
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
udf: bad mount option "codepage=3D850"
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
udf: bad mount option "codepage=3D850"
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
cdrom: open failed.
kernel BUG at vmscan.c:442!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013316d>]    Not tainted
EFLAGS: 00210202
eax: 00000040   ebx: c102320c   ecx: ffff0000   edx: c11fc000
esi: c10231f0   edi: c025f5cc   ebp: c11fdf60   esp: c11fdf3c
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=3Dc11fd000)
Stack: c11fc000 00000000 000005de 00000298 000001d0 00000011 0000001f =
000001d0=20
       c025f5cc c11fdf78 c01333b1 c11fdf8c 000001d0 0000003c 00000020 =
c11fdf9c=20
       c0133410 c11fdf8c 00000000 c025f5cc 00000000 c025f5cc 00000001 =
c11fc000=20
Call Trace:    [<c01333b1>] [<c0133410>] [<c013356e>] [<c01335c6>] =
[<c013370e>]
  [<c0105000>] [<c0107526>] [<c0133670>]

Code: 0f 0b ba 01 30 5e 23 c0 e9 86 fc ff ff c7 02 00 00 00 00 e8=20
 kernel BUG at vmscan.c:442!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013316d>]    Not tainted
EFLAGS: 00210202
eax: 00000040   ebx: c102320c   ecx: 00001aeb   edx: c383e000
esi: c10231f0   edi: c025f5cc   ebp: c383fea4   esp: c383fe80
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 16592, stackpage=3Dc383f000)
Stack: c383e000 c10948e8 00000c80 0000090f 000001d2 00000020 00000020 =
000001d2=20
       c025f5cc c383febc c01333b1 c383fed0 000001d2 0000003c 00000020 =
c383fee0=20
       c0133410 c383fed0 00000000 c025f5cc 00000000 c025f5cc 00000000 =
00000000=20
Call Trace:    [<c01333b1>] [<c0133410>] [<c01343ac>] [<c0134655>] =
[<c012efcd>]
  [<c4810cc4>] [<c013a0c4>] [<c0108fe3>]

Code: 0f 0b ba 01 30 5e 23 c0 e9 86 fc ff ff c7 02 00 00 00 00 e8=20
 kernel BUG at vmscan.c:442!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c013316d>]    Not tainted
EFLAGS: 00210202
eax: 00000040   ebx: c102320c   ecx: 00001914   edx: c37b6000
esi: c10231f0   edi: c025f5cc   ebp: c37b7e1c   esp: c37b7df8
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 16722, stackpage=3Dc37b7000)
Stack: c37b6000 c10952b4 00000c80 0000090f 000001d2 00000020 00000020 =
000001d2=20
       c025f5cc c37b7e34 c01333b1 c37b7e48 000001d2 0000003c 00000020 =
c37b7e58=20
       c0133410 c37b7e48 00000000 c025f5cc 00000000 c025f5cc 00000000 =
00000000=20
Call Trace:    [<c01333b1>] [<c0133410>] [<c01343ac>] [<c0134655>] =
[<c01345e9>]
  [<c0129c1f>] [<c012a433>] [<c0118551>] [<c012b191>] [<c012babd>] =
[<c012aafc>]
  [<c0118340>] [<c01090f4>]

Code: 0f 0b ba 01 30 5e 23 c0 e9 86 fc ff ff c7 02 00 00 00 00 e8=20
=20

------=_NextPart_000_000B_01C2C582.ED73BA00--

