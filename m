Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSHKCIj>; Sat, 10 Aug 2002 22:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317422AbSHKCIi>; Sat, 10 Aug 2002 22:08:38 -0400
Received: from mail47-s.fg.online.no ([148.122.161.47]:51665 "EHLO
	mail47.fg.online.no") by vger.kernel.org with ESMTP
	id <S317419AbSHKCIi>; Sat, 10 Aug 2002 22:08:38 -0400
Subject: Strange bug with 2.4.19 and kswapd
From: Christoffer Olsen <olsty@online.no>
To: linux-kernel@vger.kernel.org
Cc: cooker@linux-mandrake.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-4i9S0qKEoDHgHqi1U14y"
X-Mailer: Ximian Evolution 1.0.8-2mdk 
Date: 11 Aug 2002 04:12:53 -0400
Message-Id: <1029053591.1808.15.camel@TheFridge.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4i9S0qKEoDHgHqi1U14y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hey,
I'm using a beta version of Linux Mandrake 9 beta at the moment, and
I've come over a strange thing about this. I'm using the kernel binary
of 2.4.19 from mdk themselves, so I'm not quite sure if this lies in the
kernel or if it's with some patches done.

Anyway, when running certain apps (as of now i know, it is when trying
to attach a mail in evolution, and when running some of the mandrake
tools, probably with more than that tho), kswapd goes amok. Sample line
from top:
5 root      15   0     0    0     0 RW   40.1  0.0   0:12 kswapd
It suddenly takes up all of the CPU, I've seen in do eighty percent.
This was just after hitting "attach" in evolution (the only way to
reproduce it so far that I have found)
Upon killing the program that causes it, kswapd stops immediately. But,
it's not always I can reach that before the box lags up too much.
Last strange thing is I do not own a swap partition (i presume thats
what its for :)

As far as I can remember, it did not happen in 2.4.18. I might just have
been unlucky and hit on it now, but I'll try to get that confirmed ASAP.
I am pretty sure, tho.

I cannot tell any details around this, I'm everything but the uber-being
of bugreporters, so if anyone would help me debug this, it would be
greatly appreaciated.=20

--=20
gpg key:
lynx -source http://deem55.virtualave.net/olsty.asc | gpg --import

--=-4i9S0qKEoDHgHqi1U14y
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9VhyEHrnOOJSqGWwRAj0pAJ0a7wisB7tycXsxM7n/Bq3bH8YIYQCcCitS
QuR96UTSSLOe5bC8LKFlSXU=
=b92N
-----END PGP SIGNATURE-----

--=-4i9S0qKEoDHgHqi1U14y--

