Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265152AbUF1T7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265152AbUF1T7L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUF1T7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:59:10 -0400
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:41879 "EHLO
	websrv.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265152AbUF1T7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:59:07 -0400
Subject: Re: Doubt
From: Christophe Saout <christophe@saout.de>
To: esteve@eslack.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1088449171.7289.3.camel@esteve.pofhq.net>
References: <20040628184345.18629.qmail@web90103.mail.scd.yahoo.com>
	 <1088449171.7289.3.camel@esteve.pofhq.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-kwdFLUNgc7+WCH3vOrTa"
Date: Mon, 28 Jun 2004 21:58:58 +0200
Message-Id: <1088452738.719.5.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kwdFLUNgc7+WCH3vOrTa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am Mo, den 28.06.2004 um 20:59 Uhr +0200 schrieb Esteve Espu=C3=B1a Sargata=
l:

> #include <asm/string.h>         /* for strcpy */
>=20
> static char remcomOutBuffer[BUFMAX];
>=20
> strcpy(remcomOutBuffer, "OK");
>=20
> Hope it's ok.

Not really. Well, this example here works, but only if you know that you
won't overflow the buffer.

strlcpy(emcomOutBuffer, "OK", BUFMAX);

(replace "OK" with the string you wish to copy)


--=-kwdFLUNgc7+WCH3vOrTa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA4HiCZCYBcts5dM0RAs71AJwL1jcYirxjAc6y/iedhAj8OD1NhACgrex9
azuo9lMbEwC+n6AZ63FKssU=
=BRad
-----END PGP SIGNATURE-----

--=-kwdFLUNgc7+WCH3vOrTa--

