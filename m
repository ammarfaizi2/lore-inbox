Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVFQOmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVFQOmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 10:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbVFQOmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 10:42:16 -0400
Received: from lug-owl.de ([195.71.106.12]:63679 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261984AbVFQOmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 10:42:10 -0400
Date: Fri, 17 Jun 2005 16:42:09 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel eats argument=
Message-ID: <20050617144209.GI31780@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050617143642.GB17910@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20050617143642.GB17910@schottelius.org>
X-Operating-System: Linux mail 2.6.11.10lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-06-17 16:36:42 +0200, Nico Schottelius <nico-kernel@schotteliu=
s.org> wrote:
> I wanted to have 'cprofile=3Da_profile" specified to my init
> system. Now after some hours of debugging I see that
> everything that is in the form of
>   =20
>       bla=3Dblub
>=20
> is eaten by the kernel and _not_ given to init.
> Is that how it should be or is that a bug?

Well, everything the kernel doesn't understand as a parameter (eg. for
modules) actually *is* passed to init, but not as command-line
arguments, but as environment variables. You'll probably find that :-)

MfG, JBG
PS: Not including sender's email address in Cc because I'm too lame to
ACK my email for his email system...

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCsuFBHb1edYOZ4bsRAqwrAJ0dhIqXwy61vCZM62I1MM3QBLTPAACggK7b
SqvmSddPLvV4ybYWXiSPnLg=
=guCO
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
