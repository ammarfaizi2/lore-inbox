Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265753AbUBCVaA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265969AbUBCV3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:29:01 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:25224 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266051AbUBCV2O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:28:14 -0500
Subject: Re: [ANNOUNCE] udev 016 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203201359.GB19476@kroah.com>
References: <20040203201359.GB19476@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ViLuEQ8Yf/1toBgDip/d"
Message-Id: <1075843712.7473.60.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 23:28:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ViLuEQ8Yf/1toBgDip/d
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 22:13, Greg KH wrote:

Except if I miss something major, udevsend and udevd still do not
work:

--
# (export ACTION=3Dadd; export DEVPATH=3D/class/vc/vcsa7; strace -ff udevse=
nd vc)
execve("/sbin/udevsend", ["udevsend", "vc"], [/* 55 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"nosferatu", ...}) =3D 0
brk(0)                                  =3D 0x804a000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x40017000
open("/etc/ld.so.preload", O_RDONLY)    =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
close(3)                                =3D 0
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D79499, ...}) =3D 0
mmap2(NULL, 79499, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40018000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\31Y\1\000"..., 512=
) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1573165, ...}) =3D 0
mmap2(NULL, 1256716, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x4002c000
mmap2(0x40159000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x=
12c) =3D 0x40159000
mmap2(0x4015d000, 7436, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANO=
NYMOUS, -1, 0) =3D 0x4015d000
close(3)                                =3D 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x40017a80, limit:1048575,=
 seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_prese=
nt:0, useable:1}) =3D 0
munmap(0x40018000, 79499)               =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "\31\317w\302n\v\0354\261\232\247\251\314\3\351O\256Yd\347"..., 32)=
 =3D 32
close(3)                                =3D 0
exit_group(1)                           =3D ?
--

Btw - using NPTL over here ...


--=20
Martin Schlemmer

--=-ViLuEQ8Yf/1toBgDip/d
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIBKAqburzKaJYLYRAsbJAJ9ob3Eo12+COmITIexURzU1XfNv6gCfbHOM
S+5rpuEip8C0tYb5UqOkYKM=
=Tbda
-----END PGP SIGNATURE-----

--=-ViLuEQ8Yf/1toBgDip/d--

