Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTBLXXf>; Wed, 12 Feb 2003 18:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267939AbTBLXXf>; Wed, 12 Feb 2003 18:23:35 -0500
Received: from aramis.rutgers.edu ([128.6.4.2]:59285 "EHLO aramis.rutgers.edu")
	by vger.kernel.org with ESMTP id <S267937AbTBLXXd>;
	Wed, 12 Feb 2003 18:23:33 -0500
Subject: Re: O_DIRECT foolish question
From: Bruno Diniz de Paula <diniz@cs.rutgers.edu>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030212232443.GA13339@f00f.org>
References: <1045084764.4767.76.camel@urca.rutgers.edu>
	 <20030212140338.6027fd94.akpm@digeo.com>
	 <1045088991.4767.85.camel@urca.rutgers.edu>
	 <20030212224226.GA13129@f00f.org>
	 <1045090977.21195.87.camel@urca.rutgers.edu>
	 <20030212232443.GA13339@f00f.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-na3XaVT7KPVUgpEjJqgy"
Organization: Rutgers University
Message-Id: <1045092802.4766.96.camel@urca.rutgers.edu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 12 Feb 2003 18:33:23 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-na3XaVT7KPVUgpEjJqgy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-12 at 18:24, Chris Wedgwood wrote:
> On Wed, Feb 12, 2003 at 06:02:58PM -0500, Bruno Diniz de Paula wrote:
>=20
> > ext2.
>=20
> are you able to test with another fs? (reiserfs and XFS also support
> O_DIRECT)

Unfortunately not, I just have ext2 partitions here...

>=20
> > read(3, "", 4096)                       =3D 0
>=20
> odd... I'm not sure why you get this
>=20
> i tested locally here and it works as expected ... my test code is
> appended.

But your code doesn't use O_DIRECT:

if ((h =3D open("test", O_RDONLY)) < 0)

Let me know whether including O_DIRECT the test worked.

Bruno.

>=20
>=20
>   --cw
--=20
Bruno Diniz de Paula <diniz@cs.rutgers.edu>
Rutgers University

--=-na3XaVT7KPVUgpEjJqgy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+StnCZGORSF4wrt8RAho6AJ9cxXo1655hzblbTW8dlmxCi2na9ACfTb3U
lMy9515KmJCQEOd8B3wjIYY=
=opNm
-----END PGP SIGNATURE-----

--=-na3XaVT7KPVUgpEjJqgy--

