Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268098AbTBMRl3>; Thu, 13 Feb 2003 12:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbTBMRl3>; Thu, 13 Feb 2003 12:41:29 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:59028 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S268098AbTBMRl2>;
	Thu, 13 Feb 2003 12:41:28 -0500
Subject: Re: How to bypass buffer caches?
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200302131737.h1DHbIFT007308@turing-police.cc.vt.edu>
References: <1045157351.21195.134.camel@urca.rutgers.edu>
	 <200302131737.h1DHbIFT007308@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-H4JvzKycQy3wyWP0jztM"
Organization: Rutgers University
Message-Id: <1045158671.4767.138.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Feb 2003 12:51:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H4JvzKycQy3wyWP0jztM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

But what if "/dev/hda7" already has an ext2 fs set up. How am I supposed
to know which phisical blocks in the disk correspond to each of my files
in the ext2 mapping, that is, "/var/somefile" or "/usr/local/otherfile"?

Thanks,
Bruno.

On Thu, 2003-02-13 at 12:37, Valdis.Kletnieks@vt.edu wrote:
> On Thu, 13 Feb 2003 12:29:12 EST, Bruno Diniz de Paula <diniz@cs.rutgers.=
edu>  said:
>=20
> > the kernel. One option would be create a raw device on top of my disk
> > partition, but in this case I would have to learn how to map a logical
> > file name (/var/tmp/myfile) to a set of block disks. Is there any other
>=20
> What's wrong with this?
>=20
>      fd =3D open("/dev/hda7", your_flags_here);
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-H4JvzKycQy3wyWP0jztM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+S9sOZGORSF4wrt8RAtD1AJ9tZU0juj/l1Q59PLCmFJ6oPQBkfwCcCtIu
DYNxJ/3B+8pl/d2D2lffEz8=
=Akys
-----END PGP SIGNATURE-----

--=-H4JvzKycQy3wyWP0jztM--

