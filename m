Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFAIoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFAIoA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 04:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFAIoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 04:44:00 -0400
Received: from lug-owl.de ([195.71.106.12]:20892 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261336AbVFAIni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 04:43:38 -0400
Date: Wed, 1 Jun 2005 10:43:35 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Henk <Henk.Vergonet@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] new 7-segments char translation API
Message-ID: <20050601084335.GL2417@lug-owl.de>
Mail-Followup-To: Henk <Henk.Vergonet@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20050531220738.GA21775@god.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GaDTZZn2ADWB060d"
Content-Disposition: inline
In-Reply-To: <20050531220738.GA21775@god.dyndns.org>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GaDTZZn2ADWB060d
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2005-06-01 00:07:38 +0200, Henk <Henk.Vergonet@gmail.com> wrote:
> I know this 7-segments stuff probably won't be used widespread much but it
> could be important to have similar projects use the same notation, and
> use the same concepts.

I don't know if a real API is really needed for that. For example, I
played a bit with the (single) 7-segment display of one of my VAXen
running Linux. Other VAXen only have 8 LEDs in a row.  Using these LEDs
for debugging, I most probably just want to output *anything* to the
LEDs so I just use defined constants for that.

However, the principle could be reversed by using a 7-segment "font", a
mapping function and an initializer which specifies which bit belongs to
which bar of the 7-segment display... But maybe it's really worth
mplementing it as a library function...

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--GaDTZZn2ADWB060d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCnXU3Hb1edYOZ4bsRAl6PAJ9jgCmL/YEglOm/98gQxCg3P8v7dQCfSNjU
R+w/RVyuAweuM0UXl/TD+Hk=
=9uym
-----END PGP SIGNATURE-----

--GaDTZZn2ADWB060d--
