Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265436AbUBPIbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 03:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265438AbUBPIbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 03:31:09 -0500
Received: from smtp3.clb.oleane.net ([213.56.31.19]:23765 "EHLO
	smtp3.clb.oleane.net") by vger.kernel.org with ESMTP
	id S265436AbUBPIbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 03:31:05 -0500
Subject: Re: JFS default behavior
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: Jan Knutar <jk-lkml@sci.fi>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200402160545.04175.jk-lkml@sci.fi>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
	 <200402160545.04175.jk-lkml@sci.fi>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gy3Ueg6OdOIEpGep9VC5"
Organization: Adresse personnelle
Message-Id: <1076920241.11055.4.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Mon, 16 Feb 2004 09:30:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gy3Ueg6OdOIEpGep9VC5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Le lun, 16/02/2004 =C3=A0 05:45 +0200, Jan Knutar a =C3=A9crit :
> > - what happens to already existing invalid UTF-8 filenames ? Should
> > the kernel forcibly rewrite them (in 2.7.0...) to remove legacy mess
> > ? What should happen if someone plug an unconverted FS in such a
> > system afterwards ?
>=20
> What I would like would be a userspace tool, that would recurse and=20
> convert filename encodings from specified locale to UTF-8. Something=20
> like "any2utf8 -from iso8859-1 -recurse /mnt/myoldmp3disk".=20
> Does anyone know if such a tool exists already?

One can do find+ recode magic now

The question is :
- can this be automated ?
- how can one recognise and unconverted fs ?
- how can on guess the encodings(s) that have been used before on such
an fs ?

You're assuming the situation is merely a iso8859-1 to utf-8 migration.
Far from it. The core problem is everyone damn wrote what it pleased him
without considering future readers.

Cheers,

--=20
Nicolas Mailhot

--=-gy3Ueg6OdOIEpGep9VC5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAMH+pI2bVKDsp8g0RAu+5AKCrkjSjuS4obgLFnV/KWsHD/W1wOgCfTEl2
5p7EjazLOSHKAqjOzW55xmU=
=S8t0
-----END PGP SIGNATURE-----

--=-gy3Ueg6OdOIEpGep9VC5--

