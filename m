Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbTIZJnv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 05:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTIZJnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 05:43:51 -0400
Received: from smtp6.clb.oleane.net ([213.56.31.26]:28575 "EHLO
	smtp6.clb.oleane.net") by vger.kernel.org with ESMTP
	id S261437AbTIZJnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 05:43:49 -0400
Subject: Re: Keyboard oddness.
From: Nicolas Mailhot <Nicolas.Mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cMEylwu5Az2T/nqftzaS"
Organization: Adresse personelle
Message-Id: <1064569422.21735.11.camel@ulysse.olympe.o2t>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Fri, 26 Sep 2003 11:43:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cMEylwu5Az2T/nqftzaS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Vojtech Pavlik  wrote:

|> Many people have reported missing key releases, and, as a consequence
| of that,
| > stuck keys. Your reports feel a bit different: the e0 is sometimes lost=
 from
| > a key press, sometimes from a key release.

| I'm wondering if it could be a bug in the i8042.c driver ...

This is worse than that. I'm seing the same kind of bug on a pure HID+EHCI =
setup=20
and I've seen other reports of USB problems on the lists these past months.

I can't just believe everyone and his cat has suddenly a faulty/broken keyb=
oard.

The fact is software autorepeat seems extremely brittle in 2.6 and goes nut=
s every
once in a while for *everyone* (and I also seem to remember this was not al=
ways the=20
case - the first 2.5 I tried didn't go mad on my setup this only happened l=
ater in=20
2.5.7x times I think). Now maybe the underlying keyboard drivers are feedin=
g it junk
I don't know but this is no justification for the way it's been misbehaving=
 (crap=20
hardware happens, glitchy hardware is common but the autorepeat code seems =
to expect
ideal behaviour that only happens on paper)

Couldn't it at least detect there's a problem ? Most people I know do not p=
ress a key
2000+ times in a row during normal activity.

Cheers,

--=20
Nicolas Mailhot

--=-cMEylwu5Az2T/nqftzaS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/dApNI2bVKDsp8g0RAstGAKDG/PFmV1BlugyzfzDxr3pyRIJRsACg8tto
nGfpOZCDh9ALtlj9sHD6Uac=
=UUEL
-----END PGP SIGNATURE-----

--=-cMEylwu5Az2T/nqftzaS--

