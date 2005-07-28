Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVG1O2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVG1O2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 10:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVG1OZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 10:25:39 -0400
Received: from lug-owl.de ([195.71.106.12]:31169 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261503AbVG1OZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 10:25:01 -0400
Date: Thu, 28 Jul 2005 16:25:00 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jiri Slaby <jirislaby@gmail.com>, Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH] New include file for marking old style api files
Message-ID: <20050728142500.GA26706@lug-owl.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jiri Slaby <jirislaby@gmail.com>, Adrian Bunk <bunk@stusta.de>
References: <42E8E0C2.5010302@gmail.com> <20050728140230.GG3528@stusta.de> <42E8E6BD.90807@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <42E8E6BD.90807@gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-07-28 16:07:57 +0200, Jiri Slaby <jirislaby@gmail.com> wrote:
> Adrian Bunk napsal(a):
> >What's wrong with __deprecated ?
> >=20
> >
> Nothing, but this marks entire driver, not a function, that it uses.
> I.e. gazel doesn't emit any warning or so, I think; so for these cases.

So what's actually wrong with the gazel driver? I'm not an user or
author of it.

When it's the use of old APIs, I indeed think that __deprecated is
exactly what we want. If a driver is superseded by a different one (OSS
vs. ALSA, eepro100 vs e100, ...), sticking a #warning or #error right
into the driver (and not into an included header file) looks quite right
to me.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
fuer einen Freien Staat voll Freier Buerger" | im Internet! |   im Irak!   =
O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC6Oq8Hb1edYOZ4bsRAg1FAJoDAeja0Ls3T6v8tlz896DWL3/4UgCfZKhe
W6ylMLTYF9hC0lYrNQB7o88=
=bPnA
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
