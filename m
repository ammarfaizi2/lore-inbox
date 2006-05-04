Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWEDOOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEDOOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 10:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbWEDOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 10:14:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:43702 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750726AbWEDOOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 10:14:14 -0400
X-Authenticated: #2308221
Date: Thu, 4 May 2006 16:14:03 +0200
From: Christian Trefzer <ctrefzer@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Herbert Rosmanith <kernel@wildsau.enemy.org>, linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
Message-ID: <20060504141402.GB8348@hermes.uziel.local>
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <1146750532.20677.38.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan et.al.,

On Thu, May 04, 2006 at 02:48:52PM +0100, Alan Cox wrote:
>=20
> Please try the libata PATA patches instead of the old IDE layer.
>=20

I'd love to, but currently I'm running git kernels on both of my
machines, and unfortunately 2.6.16-ide1 won't apply ; )

Since you've been busy I didn't want to bother you, but now that you
mention your PATA efforts again, is there a git tree to pull from, which
contains code similar to that in the latest patches?

I understand that your work is gradually flowing through Jeff, and over
to Linus from there which adds up to, but is not the only reason for,
the huge amount of rejects. I'd rather not waste my time messing with
unclean patching attempts, otherwise my studies _are_ going to kill me.

I have a remote entry for Jeff's pata-drivers branch, but that one won't
discover any of my ide controllers so far. Your patches have been
working very reliably though, so I am annoyed (to say the least) to have
the stuff about missing write barrier support back in my logs. Since I
need John Linville's tree for some WiFi hackery tryouts, I can't seem to
get around running git kernels these days, so I'm back to drivers/ide.
Sigh.

If you've got something for me I'd be happy to keep test-driving the
good stuff some more. It had been working very well for me until the
switch from tar/patch to git.

Keep up the good work : )
Thanks a bunch,
Chris


--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQIVAwUBRFoMKV2m8MprmeOlAQJLshAAiu28iReaKSt8TkFplR7VCshXdhARz3B+
56ZS3S+zq96WlDx+MZEPUD+PURw+K4yKhhTl0JGUyOHmJFZWhTlB9mSpjzNiPtMg
HZnAV8EOf/Fevd1aUIIa5BoH8Iidixqns02hBmZj+KnS3Zb5fEhS3gfDTZnfDsv6
6z6ZUnR2uVGdj7b2XKDcc3o+B9JznO2OkvV1VqV98tX1kANAUcj5vFfRPF2D3lF5
CDbCavSI7eZboPUQoQ3W+P8IZEd3bRljNL1FE8087CewFkThm/7d2aHMWEJ+GEr6
E3rR0O7adg5NukCgI0X6LcAk4OlsROYB1fcD6sRlT0G173O2KMsdemypwc0lpIpa
UuPP52nmzE2CnDPD2g0K0X04XTxkZEsxLTBVhERF4/ATnOKQUMV7VXarh4GLTTuO
2RTW8IhS5kPW+BoFPRgsXq3DUZOnjnhMjuv5eVQPoY6pxC73MCdeEmyVmPdvUJq1
ZVqECTkOUrtpmR9cDvwDCP5ZsYTjVmqXbNKVL5Y+Vx1eTlIPNErDj8nLShGldzai
Bnd1tZDFCC6pzo+Vp1aUO6RVh+v1Z/XleiZrfDXJMjuvHb9Fi8b70Ep0YpskPWHS
WsiahoeINHTf9giAhcA3gk3mfUIgFuq0Krb8HleV0d7Zd0wbxRNvzFCY5I36hReB
bV/EPJOFV/4=
=JM85
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--

