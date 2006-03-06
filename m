Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751959AbWCFJmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbWCFJmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 04:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWCFJmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 04:42:05 -0500
Received: from lug-owl.de ([195.71.106.12]:30415 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1751959AbWCFJmD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 04:42:03 -0500
Date: Mon, 6 Mar 2006 10:41:57 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "Paul D. Smith" <psmith@gnu.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] change kbuild to not rely on incorrect GNU make behavior
Message-ID: <20060306094157.GL19232@lug-owl.de>
Mail-Followup-To: "Paul D. Smith" <psmith@gnu.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <E1FG1UQ-00045B-5P@fencepost.gnu.org> <20060305231312.GA25673@mars.ravnborg.org> <17419.34083.172540.639486@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aSoblPWN/K2Aktn9"
Content-Disposition: inline
In-Reply-To: <17419.34083.172540.639486@lemming.engeast.baynetworks.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--aSoblPWN/K2Aktn9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-05 19:41:07 -0500, Paul D. Smith <psmith@gnu.org> wrote:
> OK.  Note that this:
>=20
>   sr> -.PHONY: tar%pkg
>   sr> +PHONY +=3D tar%pkg
>   sr>  tar%pkg:
>=20
> won't do what you expect.  tar%pkg is a pattern rule, but .PHONY doesn't
> take patterns so you're declaring the actual file named literally
> 'tar%pkg' to be phony.

Easy to fix. There are currently three flavours of tar-packages:

	tar-pkg
	targz-pkg
	tarbz2-pkg

Just add them individually.

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--aSoblPWN/K2Aktn9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEDAPlHb1edYOZ4bsRAodsAJ97NzM0HLxNF5Yuutt8QPzxWU9vAgCfYKvT
3sTxSSPSjMtOR1EDFfrFJ+M=
=T4d9
-----END PGP SIGNATURE-----

--aSoblPWN/K2Aktn9--
