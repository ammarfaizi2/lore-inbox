Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266240AbUA2QwS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUA2QwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:52:17 -0500
Received: from wblv-238-222.telkomadsl.co.za ([165.165.238.222]:39810 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266240AbUA2QwL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:52:11 -0500
Subject: Re: [ANNOUNCE] udev 015 release
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040126215036.GA6906@kroah.com>
References: <20040126215036.GA6906@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rRcMuSKScG9nhXtLsLAq"
Message-Id: <1075395125.7680.21.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 29 Jan 2004 18:52:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rRcMuSKScG9nhXtLsLAq
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-01-26 at 23:50, Greg KH wrote:

Is there a known issue that the daemon do not spawn?

--
nosferatu udev-015 # DEVPATH=3D/block/hda ACTION=3Dadd strace -ff udevsend
block
execve("/sbin/udevsend", ["udevsend", "block"], [/* 55 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"nosferatu", ...}) =3D 0
brk(0)                                  =3D 0x804a000
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40000000
open("/etc/ld.so.preload", O_RDONLY)    =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
close(3)                                =3D 0
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D79435, ...}) =3D 0
mmap2(NULL, 79435, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40001000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\31YQA4"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=3D1519742, ...}) =3D 0
mmap2(0x41500000, 1256716, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D
0x41500000
mmap2(0x4162d000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x12c) =3D 0x4162d000
mmap2(0x41631000, 7436, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x41631000
close(3)                                =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40015000
set_thread_area({entry_number:-1 -> 6, base_addr:0x40015070,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) =3D 0
munmap(0x40001000, 79435)               =3D 0
open("/dev/urandom", O_RDONLY)          =3D 3
read(3, "\271\5\352\360\17,R\261X\341\265\335n\37\335!g\'\17\2\262"...,
32) =3D 32
close(3)                                =3D 0
exit_group(-22)                         =3D ?
--


Thanks,

--=20
Martin Schlemmer

--=-rRcMuSKScG9nhXtLsLAq
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAGTo1qburzKaJYLYRAp6vAJ0WubViKmKOoXfd+G6Jn4oC7cbiNwCfXwRN
Z8s9jGN8PZg/X1mMtiIjEDk=
=v+ry
-----END PGP SIGNATURE-----

--=-rRcMuSKScG9nhXtLsLAq--

