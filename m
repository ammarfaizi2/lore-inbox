Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTLDSqK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 13:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTLDSqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 13:46:10 -0500
Received: from [68.114.43.143] ([68.114.43.143]:30932 "EHLO wally.rdlg.net")
	by vger.kernel.org with ESMTP id S263486AbTLDSpN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 13:45:13 -0500
Date: Thu, 4 Dec 2003 13:45:07 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Andre Tomt <lkml@tomt.net>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: lilo and system maps?
Message-ID: <20031204184507.GK16568@rdlg.net>
Mail-Followup-To: Maciej Zenczykowski <maze@cela.pl>,
	Andre Tomt <lkml@tomt.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20031204181504.GG16568@rdlg.net> <Pine.LNX.4.44.0312041935170.26684-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3eH4Qcq5fItR5cpy"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312041935170.26684-100000@gaia.cela.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3eH4Qcq5fItR5cpy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thus spake Maciej Zenczykowski (maze@cela.pl):

> >=20
> > {0}:/usr/share/doc/lire>strings /boot/vmlinuz-2.6 | grep -i 2.[46] | he=
ad
> > 2.6.0-test11-bk2 (root@wally) #3 SMP Thu Dec 4 12:41:42 EST 2003
> > M2#6gbQ+
> > {2 6B
>=20
> Of course the correct solution is to have the kernel version in the file=
=20
> name...  and have linux-current or whatever as a symlink.  Besides truth=
=20
> be told the kernel version is far too little to identify a kernel anyway,=
=20
> there's also compilation options - they can change a lot - and all the=20
> patches which were/are applied to it.  I keep System.map-`uname -r`,
> vmlinuz-`uname -r`, .config-`uname -r`, descr-`uname -r` in my /boot dirs=
=20
> - the first three come from the kernel and the last is a text file=20
> containing notes about what patches were applied (I keep an up to date=20
> descr file in each kernel source dir).
>=20
> Cheers,
> MaZe.
>=20


I'm maintaing machines that pre-exist me and many don't have
vmlinuz-`uname -r` naming and can't quite reboot the machine on
different kernels just to find out what it is.

Did the symlink think but it got ugly after a while when I had 6 kernel,
6 System.map files and a bunch of symlinks.  Once I fully drop the 2.4
on this set of machines I can move back but it was just ugly for a
while.


:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | GPG Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Life is not a destination, it's a journey.
  Microsoft produces 15 car pileups on the highway.
    Don't stop traffic to stand and gawk at the tragedy.

--3eH4Qcq5fItR5cpy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/z4Cz8+1vMONE2jsRAouQAKCa3zyAWFSbLOsDmcwbHz/ZGS9DmgCfcTn6
8+WyAupSf3D/6RGvPxzYJRc=
=PjkD
-----END PGP SIGNATURE-----

--3eH4Qcq5fItR5cpy--
