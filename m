Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265423AbSLINXR>; Mon, 9 Dec 2002 08:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSLINXR>; Mon, 9 Dec 2002 08:23:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:50747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265423AbSLINXK>;
	Mon, 9 Dec 2002 08:23:10 -0500
Date: Mon, 9 Dec 2002 14:30:58 +0100
To: linux-kernel@vger.kernel.org
Cc: linux-laptop@vger.kernel.org, linux-ide@vger.kernel.org
Subject: 486 laptop apm problems
Message-ID: <20021209133058.GA3724@mob.wid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
x-gpg-fingerprint: 717B AE57 49B3 410F A733  FE6A 2D43 E1E3 CF28 6A67
x-gpg-key: wwwkeys.de.pgp.net
From: Felix Triebel <ernte23@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

when using APM with a Compaq 4/33C LTE Lite laptop, I get the following
kernel messages:

-----------------------------------------------------------------------
Linux version 2.4.20-rc4-ac1 (root@triebel) (gcc version 2.95.4 20011002 (D=
ebian prerelease)) #2 Fre Nov 29 11:10:52 CET 2002
BIOS-provided physical RAM map:
 BIOS-e801: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e801: 0000000000100000 - 0000000001440000 (usable)
20MB LOWMEM available.
On node 0 totalpages: 5184
zone(0): 4096 pages.
zone(1): 1088 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D302
Initializing CPU#0
Console: colour VGA+ 80x34
Calibrating delay loop... 16.58 BogoMIPS
Memory: 18760k/20736k available (728k kernel code, 1428k reserved, 162k dat=
a, 48k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
ramfs: mounted with options: <defaults>
ramfs: max_pages=3D2365 max_file_pages=3D0 max_inodes=3D0 max_dentries=3D23=
65
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
CPU:     After generic, caps: 00000000 00000000 00000000 00000000
CPU:             Common caps: 00000000 00000000 00000000 00000000
CPU: 486
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 50MHz system bus speed for PIO modes; override with idebus=3D=
xx
hda: QUANTUM DAYTONA514A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
hda: 1005569 sectors (515 MB) w/98KiB Cache, CHS=3D997/16/63
Partition check:
 hda: hda1 hda2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Adding Swap: 31240k swap-space (priority -1)
Real Time Clock Driver v1.10e
apm: BIOS version 0.1 Flags 0x03 (Driver version 1.16)
apm: an event queue overflowed
ide0: unexpected interrupt, status=3D0x80, count=3D1
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x03f8 (irq =3D 4) is a 16450
ttyS01 at 0x02f8 (irq =3D 3) is a 16450
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
PPP BSD Compression module registered
PPP Deflate Compression module registered
PPPIOCDETACH file->f_count=3D3
ide0: unexpected interrupt, status=3D0x80, count=3D2
ide0: unexpected interrupt, status=3D0x80, count=3D3
Unable to handle kernel NULL pointer dereference at virtual address 000000d8
 printing eip:
c011dd5f
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c011dd5f>]    Not tainted
EFLAGS: 00010246
eax: c1030080   ebx: c101f320   ecx: 00000400   edx: 00000000
esi: c0999000   edi: c10731e8   ebp: c1030080   esp: c0a97ed0
ds: 0018   es: 0018   ss: 0018
Process 00hwclock (pid: 759, stackpage=3Dc0a97000)
Stack: c10731cc c10731cc c10731e8 080c1078 c011dee3 c10731cc c0ebeebc 080c1=
078=20
       00000001 c0db5304 c10731cc 080c1078 c10731e8 c0ebeebc c0b6e080 c010c=
df7=20
       c10731cc c0ebeebc 080c1078 00000001 c0a96000 ffff0006 c010cce0 bffff=
bec=20
Call Trace:    [<c011dee3>] [<c010cdf7>] [<c010cce0>] [<c0117c49>] [<c0114a=
0a>]
  [<c0114936>] [<c010e03d>] [<c0106d34>]

Code: 2b 82 d8 00 00 00 69 c0 c5 4e ec c4 c1 f8 02 c1 e0 0c 03 82=20
-----------------------------------------------------------------------

why does apmd frequently crash?
what do all these ide and apm messages mean?
how should I use such an old apm bios?

Please CC me, I'm not subscribed to this list.

regards,
Felix T.

--=20

/"\  ASCII RIBBON CAMPAIGN
\ /  AGAINST HTML MAIL
 X   AND POSTINGS  :)
/ \  http://www.dcoul.de/

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iD8DBQE99JsSLUPh488oamcRAutSAJ0V3Q/ajx1+IsUSg23gHmwraUXkEQCfePoO
+8/B0qt8PRVx930Be5Uhiis=
=hbQK
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
