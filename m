Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTEEGzx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 02:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTEEGzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 02:55:53 -0400
Received: from dsl-62-3-122-162.zen.co.uk ([62.3.122.162]:28332 "EHLO
	marx.trudheim.com") by vger.kernel.org with ESMTP id S261973AbTEEGzw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 02:55:52 -0400
Subject: Re: Linux 2.5.69
From: Anders Karlsson <anders@trudheim.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1052116306.31300.50.camel@marx>
References: <Pine.LNX.4.44.0305042137370.6183-100000@home.transmeta.com>
	 <1052116306.31300.50.camel@marx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VCqTPs8Q+SqW8S4B/it/"
Organization: Trudheim Technology Limited
Message-Id: <1052118495.25950.55.camel@marx>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4Rubber Turnip 
Date: 05 May 2003 08:08:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VCqTPs8Q+SqW8S4B/it/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-05-05 at 07:31, Anders Karlsson wrote:
> On Mon, 2003-05-05 at 05:41, Linus Torvalds wrote:
>=20
> > Make sure to also test with regular 1x AGP (and no fast write stuff etc=
).=20
> > A lot of motherboards really aren't going to like 4x and some other=20
> > settings (in particular, enabling fast writes seems to be a very iffy=20
> > proposition indeed).
>=20
> Will try that in case that fixes the problems I see.

Hi there again,

This did indeed fix the problem seen on the IBM X31
with Radeon Mobility LY. Setting AGPMode to 1 cured it
of the "black screen on 2nd and later starts". This is
on kernel 2.4.21-rc1, acpi and apm both switched off.

Many many thanks for that tip Linus. :-)))

Regards,

/Anders

--=-VCqTPs8Q+SqW8S4B/it/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2-rc1-SuSE (GNU/Linux)

iD8DBQA+tg3fLYywqksgYBoRAuVMAJ9BufZ9UF/aSXqVr0SiuI2OGWGwQwCg4xNj
fDj1TLVJwAaplgtqUBSuHlI=
=uVdW
-----END PGP SIGNATURE-----

--=-VCqTPs8Q+SqW8S4B/it/--

