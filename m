Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262392AbSLJPn3>; Tue, 10 Dec 2002 10:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbSLJPn3>; Tue, 10 Dec 2002 10:43:29 -0500
Received: from B5320.pppool.de ([213.7.83.32]:47252 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S262392AbSLJPn1>; Tue, 10 Dec 2002 10:43:27 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Daniel Egger <degger@fhm.edu>
To: Juan Quintela <quintela@mandrakesoft.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <m27kei9hd3.fsf@demo.mitica>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	 <20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja>
	 <m27kei9hd3.fsf@demo.mitica>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gLpliAlfutcB7JigjYgg"
Organization: 
Message-Id: <1039534841.31316.33.camel@sonja>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Dec 2002 16:40:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gLpliAlfutcB7JigjYgg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Die, 2002-12-10 um 13.40 schrieb Juan Quintela:

> Have you tested it?

Sort of.... :/

> Here, we got cmov to work if the two operands are registers, if any of
> the operands is in memory, it don't work.

Now *this* is really informative because it explains why my
testapplication which uses=20
 80488c7:       0f 43 d0                cmovae %eax,%edx
doesn't SEGILL.

> Been there, been burned :p=20

Me too, just this morning.

--=20
Servus,
       Daniel

--=-gLpliAlfutcB7JigjYgg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA99gr5chlzsq9KoIYRAnluAJ9q6KtjCyy7x+6HcEzb/V7J2lTLzgCg4b2+
ntTbd1HVId1WDckjhjmRSyE=
=qAZ0
-----END PGP SIGNATURE-----

--=-gLpliAlfutcB7JigjYgg--

