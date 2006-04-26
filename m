Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWDZUBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWDZUBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbWDZUBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:01:36 -0400
Received: from lug-owl.de ([195.71.106.12]:4846 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S932370AbWDZUBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:01:35 -0400
Date: Wed, 26 Apr 2006 22:01:34 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Cc: David Schwartz <davids@webmaster.com>
Subject: Re: C++ pushback
Message-ID: <20060426200134.GS25520@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	David Schwartz <davids@webmaster.com>
References: <20060426034252.69467.qmail@web81908.mail.mud.yahoo.com> <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YyxzkC/DtE3JUx8+"
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOENKLIAB.davids@webmaster.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YyxzkC/DtE3JUx8+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-26 12:25:19 -0700, David Schwartz <davids@webmaster.com> wr=
ote:
[Variable names that are reserved in C++]
> 	And, FWIW, it isn't even necessary to change those names. That is only
> needed to compile the kernel in C++, which is not what anyone was talking
> about. Supporting C++ modules, for example, would work fine even if the
> kernel had variables called 'class' or 'private'. (Though things could be
> done a lot more cleanly if it didn't as it would require some remapping
> before and after compilation.)

There's one _practical_ thing you need to keep in mind: you'll either
need 'C++'-clean kernel headers (to interface low-level kernel
functions) or a separate set of headers.

For separate headers, I see the problem of keeping them synchronized
with the kernel. The clean-up-kernel-headers-for-userspce-consumption
guys already took that bullet once and up to now, there's no "real"
result. (That's while we all know that kernel values *are* somewhat
for the userspace guys:-)  I see an even smaller user-base for
separate C++ kernel headers (and thus more work per person)--and I
think that the current in-kernel headers just won't be C++ compatible,
ever[*].

MfG, JBG
[*] Famous last words...

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 f=C3=BCr einen Freien Staat voll Freier B=C3=BCrger"  | im Internet! |   i=
m Irak!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--YyxzkC/DtE3JUx8+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFET9GeHb1edYOZ4bsRAkxJAJ499PL3iZcfttnPxXanZVQFMBQmWgCcDai/
+g/w/625uqBE8Vrt01nWcGM=
=ErHO
-----END PGP SIGNATURE-----

--YyxzkC/DtE3JUx8+--
