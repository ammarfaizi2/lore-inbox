Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316623AbSHRFBw>; Sun, 18 Aug 2002 01:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSHRFBw>; Sun, 18 Aug 2002 01:01:52 -0400
Received: from [216.38.156.94] ([216.38.156.94]:42768 "EHLO
	mail.networkfab.com") by vger.kernel.org with ESMTP
	id <S316623AbSHRFBv>; Sun, 18 Aug 2002 01:01:51 -0400
Date: Sat, 17 Aug 2002 22:05:49 -0700
From: Dmitri <dmitri@users.sourceforge.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
Message-ID: <20020818050549.GT30425@usb.networkfab.com>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Oliver Xymoron <oxymoron@waste.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20020818044242.GI21643@waste.org> <Pine.LNX.4.44.0208172151440.1829-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Wlbg71WMOPzcvmIn"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208172151440.1829-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Wlbg71WMOPzcvmIn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Quoting Linus Torvalds <torvalds@transmeta.com>:

> Be realistic. This is what I ask of you. We want _real_world_ security,=
=20
> not a completely made-up-example-for-the-NSA-that-is-useless-to-anybody-=
=20
> else.
>=20
> All your arguments seem to boil down to "people shouldn't use /dev/random=
=20
> at all, they should use /dev/urandom".

Wouldn't it be much easier to ask -very few- people (GnuPG/SSL/SSH teams
primarily)  to use /dev/super-reliable-mathematically-proven-random if
available, instead of asking much larger crowd to hack their code? This
will be backward compatible, and at the same time offers a much better
randomness for those who care about it. Myself, I read 128-bit session
keys for multiple, not-so-secure, short connections from /dev/random and
it would be sad if it runs out of data.

Also, /dev/random may take data from /dev/super-...random until it sucks=20
it dry, and then switches to less secure sources. This will guarantee that=
=20
the enthropy of readings is -not worse than-, and for moderate requests is=
=20
much better.

Dmitri

--=20
16. The Evil Overlord will not risk his life to save yours. Why risk
  yours for his?
  ("Evil Overlord" by Peter Anspach and John VanSickl)

--Wlbg71WMOPzcvmIn
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9XystXksyLpO6T4IRAvYXAJ92VA0jIwtIrCd/+6Ne7pbwKpl0fgCfUW9U
OE/R255LaFp65E6ZxOA7/Eg=
=VNG0
-----END PGP SIGNATURE-----

--Wlbg71WMOPzcvmIn--
