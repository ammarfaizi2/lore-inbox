Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315420AbSGAHNq>; Mon, 1 Jul 2002 03:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315438AbSGAHNp>; Mon, 1 Jul 2002 03:13:45 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:698 "EHLO
	alien.meansolutions.com") by vger.kernel.org with ESMTP
	id <S315420AbSGAHNo>; Mon, 1 Jul 2002 03:13:44 -0400
Date: Mon, 1 Jul 2002 08:15:48 +0100
From: Anders Karlsson <anders.karlsson@meansolutions.com>
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spacewalker SS40
Message-ID: <20020701071548.GA1047@alien.meansolutions.com>
References: <20020630151510.GA21888@alien.meansolutions.com> <3D1F62B5.30502@candelatech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <3D1F62B5.30502@candelatech.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2002 at 12:57:41PM -0700, Ben Greear wrote:
> Anders Karlsson wrote:
[snip: PCI problems with Shuttle SS40 + kernel 2.4.18]
>=20
> I don't know the exact problem, but if you add: pci=3Dbios to
> the kernel boot comand line args, then it seems to work fine,
> at least with RH 7.3.
>=20
> I'm also running a rc1 kernel w/out problems on it.
>=20
> Ben

Ben,

That indeed solved the problem. It has been suggested to me that the
chipset on the FS40 motherboard (used in the SS40) is not yet properly
recognized and handled by the kernel and so going through the bios
instead will work.

Many thanks as your suggestion did solve the problem. Hopefully we
will soon see a kernel that will be able to use the PCI bus in raw
mode on the FS40 motherboard. :-)

Cheers!

--=20
Anders Karlsson <anders dot karlsson at meansolutions dot com>

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IAGkLYywqksgYBoRAvSXAKDSsYkW+PqvW8w7b6tOfHv06DMkJQCgsO7q
Pb1f4KDiFo/Eg81cY5p3JKc=
=zAaK
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
