Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262745AbTCPUAk>; Sun, 16 Mar 2003 15:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262748AbTCPUAk>; Sun, 16 Mar 2003 15:00:40 -0500
Received: from adsl-67-121-154-32.dsl.pltn13.pacbell.net ([67.121.154.32]:7904
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262745AbTCPUAi>; Sun, 16 Mar 2003 15:00:38 -0500
Date: Sun, 16 Mar 2003 12:11:24 -0800
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: con@kolivas.org
Subject: Weirdness with 2.4.20-ck4
Message-ID: <20030316201124.GA2849@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

So I tried out 2.4.20-ck4 on my server box, which continually leans
towards the experimental because, well, it seems to work fine.

For 13 days, everything was peachy. Then on the 14th morning I wake
up and dhcp3-server is not responding timely, since my laptop
is unable to acquire an IP address automatically. I serial in and=20
init has gone D and is eating 99.8% of the CPU.

Every single process under init was DEFUNCT!

New processes also were defunct as well, after being started. I guess
bash was somehow not affected when I logged in.

I can't provide a dmesg, since the machine eventually stopped responding
and I had to hard reboot it. But unless I know for sure what's going on
soon, I'll need to move back to a vanilla kernel or perhaps try out
2.4.20aa, without the rest of the 'desktop' tuning stuff that I don't
really make use of.

Sorry I can't give much info, except possibly my .config. You can get it
at http://triplehelix.org/~joshk/linux/config.gz. If this happens again
I'll be sure to get some pstree output logged somewhere. (Would slabinfo
be useful too in this kind of situation?)

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+dNpsT2bz5yevw+4RAqyKAKCA6f6QL0GfdM46fQjDt8z0ApZbcACeOEzS
b3ZPy0PaWJuzZRgTAa/Oqyo=
=NWNE
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
