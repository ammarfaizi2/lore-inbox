Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261644AbSLZQal>; Thu, 26 Dec 2002 11:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSLZQal>; Thu, 26 Dec 2002 11:30:41 -0500
Received: from lennier.cc.vt.edu ([198.82.162.213]:8966 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S261644AbSLZQaj>; Thu, 26 Dec 2002 11:30:39 -0500
Subject: 2.4.18 boot error
From: "Richard B. Tilley " "(Brad)" <rtilley@vt.edu>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-GHhcpqUGx+flqjn56OK3"
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 Dec 2002 11:38:54 -0500
Message-Id: <1040920734.1683.13.camel@oubop4.bursar.vt.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GHhcpqUGx+flqjn56OK3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

I think this error has something to do with the atapi Iomega 100MB zip
drive, but I'm not sure. The kernel is 2.4.18 vanilla on an Intel P3.
Here's a snip from the logs:

Dec 26 11:13:37 free4 kernel: LVM version 1.0.1-rc4(ish)(03/10/2001)
module loaded
Dec 26 11:13:37 free4 kernel: hdc: ATAPI 48X CD-ROM drive, 120kB Cache
Dec 26 11:13:37 free4 kernel: Uniform CD-ROM driver Revision: 3.12
Dec 26 11:13:37 free4 kernel: cdrom: open failed.
Dec 26 11:13:37 free4 kernel: ide-floppy driver 0.97.sv
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512
sector size, 2941 rpm
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D  0, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: ide-floppy: hdd: I/O error, pc =3D 1b, key
=3D  2, asc =3D 3a, ascq =3D  0
Dec 26 11:13:37 free4 kernel: hdd: No disk in drive
Dec 26 11:13:37 free4 kernel: loop: loaded (max 8 devices)
Dec 26 11:13:37 free4 kernel:  [events: 00000036]
Dec 26 11:13:37 free4 kernel: md: autorun ...
Dec 26 11:13:37 free4 kernel: md: considering
ide/host0/bus0/target1/lun0/part2 ...
Dec 26 11:13:37 free4 kernel: md:  adding
ide/host0/bus0/target1/lun0/part2 ...
Dec 26 11:13:37 free4 kernel: md:  adding
ide/host0/bus0/target0/lun0/part2 ...
Dec 26 11:13:37 free4 kernel: md: created md0
Dec 26 11:13:37 free4 kernel: md:
bind<ide/host0/bus0/target0/lun0/part2,1>
Dec 26 11:13:37 free4 kernel: md:
bind<ide/host0/bus0/target1/lun0/part2,2>
Dec 26 11:13:37 free4 kernel: md: running:
<ide/host0/bus0/target1/lun0/part2><ide/host0/bus0/target0/lun0/part2>
Dec 26 11:13:37 free4 kernel: md: updating md0 RAID superblock on device
Dec 26 11:13:37 free4 kernel: md: ... autorun DONE.

This is a log server that we use for remote sysloging. It uses linear
software raid to join a few disks together to make one big virtual unit
for the logs. Other than this task, it does nothing else and appears to
work just fine.=20

The error hdd error message started today when we upgraded to the 2.4.18
kernel. Is this something that we should be concerned about? Please cc
me with any replies as I'm not on the kernel list.

Thanks,


--=-GHhcpqUGx+flqjn56OK3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+CzCdPJE6j+LlAWERAq/kAJ95XUhVIYyVp8Afc7yAFfv5C0EGXgCbBd5K
F5qiO6xfTSO/AKUR0HdC0W8=
=nGzz
-----END PGP SIGNATURE-----

--=-GHhcpqUGx+flqjn56OK3--

