Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265798AbTAIJuH>; Thu, 9 Jan 2003 04:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265806AbTAIJuH>; Thu, 9 Jan 2003 04:50:07 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:31982 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265798AbTAIJuG>; Thu, 9 Jan 2003 04:50:06 -0500
Subject: Re: 2.4.18-14 kernel stuck during ext3 umount with ping still
	responding
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: yuval yeret <yuval_yeret@hotmail.com>
Cc: linux-kernel@vger.kernel.org, yuval@exanet.com
In-Reply-To: <F12N44yQegpeDBHkKx400013b3e@hotmail.com>
References: <F12N44yQegpeDBHkKx400013b3e@hotmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WkcUIMSzSbID3glHGhXa"
Organization: Red Hat, Inc.
Message-Id: <1042106287.1355.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 09 Jan 2003 10:58:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WkcUIMSzSbID3glHGhXa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-01-09 at 10:38, yuval yeret wrote:
> Hi,
>=20
> I'm running a 2.4.18-14 kernel with a heavy IO profile using ext3 over RA=
ID=20
> 0+1 volumes.
>=20
> >From time to time I get a black screen stuck machine while trying to umo=
unt=20
> a volume during an IO workload (as part of a failback solution - but afte=
r=20
> killing all IO processes ), with ping still responding, but everything el=
se=20
> mostly dead.
>=20

> I'm hoping the ext3fix.patch will solve this problem... am trying that no=
w.

this got fixed in the recent erratum kernel 2.4.18-19.8.0

--=-WkcUIMSzSbID3glHGhXa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+HUevxULwo51rQBIRAkm7AJ41xJj/FVnfRJRuO6ZAvMG/NQ3faACeL8ce
aTl1czuOYqpJEr5ik+Dfuv8=
=ZPSR
-----END PGP SIGNATURE-----

--=-WkcUIMSzSbID3glHGhXa--
