Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbTF0Wva (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTF0Wv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:51:29 -0400
Received: from cpt-dial-196-30-178-116.mweb.co.za ([196.30.178.116]:23168 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S264887AbTF0WvW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:51:22 -0400
Subject: Re: [PATCH] O1int for 2.5.73
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Con Kolivas <kernel@kolivas.org>
Cc: Mike Galbraith <efault@gmx.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <1056717535.5499.36.camel@workshop.saharacpt.lan>
References: <1056717535.5499.36.camel@workshop.saharacpt.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uBcQ0O2INYniRp8MmZvs"
Organization: 
Message-Id: <1056755206.8020.16.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 28 Jun 2003 01:06:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uBcQ0O2INYniRp8MmZvs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Here is an updated version of the O1int patch designed to improve=20
> interactivity.
>=20
> This change addresses the difficulty of new tasks in heavy load being=20
> recognised as interactive by decreasing the amount of time considered in =
the=20
> interactivity equation, but dropping that decrease exponentially till it =
gets=20
> to the MAX_SLEEP_AVG.
>=20
> This should improve the startup time of new apps in heavy load and lessen=
=20
> audio stalls when loads are high _and_ then the audio app is started.
>=20
> Please test and comment.
>=20

Don't try this on a P4 with Hyper Threading enabled 8)

When doing a make -j6 even, mouse/keyboard/window switching/whatever
takes ages to respond.  Worked fine without (even with a make -j20),
just tried this for fun.


Regards,

--=20

Martin Schlemmer




--=-uBcQ0O2INYniRp8MmZvs
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+/M4GqburzKaJYLYRAvydAJ4zD+a0JQo0kAXln+F3YUfUlWc7oQCfZ2TD
4/3I5Slj2NBm48vvjWuFwQQ=
=zqMd
-----END PGP SIGNATURE-----

--=-uBcQ0O2INYniRp8MmZvs--

