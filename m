Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVA1S4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVA1S4F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVA1S4E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:56:04 -0500
Received: from vds-320151.amen-pro.com ([62.193.204.86]:4999 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262722AbVA1SzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:55:14 -0500
Subject: Re: [PATCH] OpenBSD Networking-related randomization port
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: netdev@oss.sgi.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050128101825.388990a0@dxpl.pdx.osdl.net>
References: <1106932637.3778.92.camel@localhost.localdomain>
	 <20050128174046.GR28047@stusta.de>
	 <1106934475.3778.98.camel@localhost.localdomain>
	 <20050128101825.388990a0@dxpl.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-f3UObqIKh2Ao37zlI3Kx"
Date: Fri, 28 Jan 2005 19:54:36 +0100
Message-Id: <1106938476.3864.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f3UObqIKh2Ao37zlI3Kx
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 28-01-2005 a las 10:18 -0800, Stephen Hemminger escribi=F3:
> This is a very transitory effect, it works only because your machine
> is then different from the typical Linux machine; therefore the scanner
> will go on to the next obvious ones. But if this gets incorporated widely
> then the rarity factor goes away and this defense becomes useless.

I would prefer to say that such "rarity factor" comes directly from the
"rarity factor" given by the PRNG.

So, we should take "rarity factor" as the PRNG seed entropy and not as a
predictable value (not in a reasonable time manner, which is the goal of
most crypto-related developments, to make as much difficult as possible
to cause an information leak, and if such leak happens, ensure that the
information is no longer needed, private, confidential, critical,
whateverelse) (AFAIK).

So, there's no point at that claim.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-f3UObqIKh2Ao37zlI3Kx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB+opsDcEopW8rLewRApOoAKCpQhJNui44vkW94QMoM5y6LaSXnQCffFEg
DNEiog8zbrgel/5QNd7FK5M=
=VLlc
-----END PGP SIGNATURE-----

--=-f3UObqIKh2Ao37zlI3Kx--

