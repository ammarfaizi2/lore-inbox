Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUBGEU4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbUBGEU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:20:56 -0500
Received: from hostmaster.org ([80.110.173.103]:31361 "HELO hostmaster.org")
	by vger.kernel.org with SMTP id S265609AbUBGEUw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:20:52 -0500
Subject: 2.6.2: still no working de21041 driver
From: Thomas Zehetbauer <thomasz@hostmaster.org>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-gfvttDL9ZpeaLnunfk8g"
Message-Id: <1076127649.1936.19.camel@hostmaster.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.3 (1.5.3-1) 
Date: Sat, 07 Feb 2004 05:20:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-gfvttDL9ZpeaLnunfk8g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

unfortunately there is still no working driver for the Digital Equipment
Corporation DECchip 21041 card in in kernel 2.6.2.

The de4x5 driver used to work with 2.4.* but causes a lockup immediately
after bringing up the interface when SMP is enabled, it does not even
produce an oops message anymore. See
http://bugzilla.kernel.org/show_bug.cgi?id=3D1855

With the de2104x driver I can get the network interface up but it fails
to receive any packets.

Tom


--=-gfvttDL9ZpeaLnunfk8g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iQEVAwUAQCRnoWD1OYqW/8uJAQL8gQf9GFP0ocSpiI25UMiVp4awf668FhwUltc4
LQbM5k+GGhhQc2fq08Kz7FT90HWemt9HTi7QqTvgqK3Nr/Jh4pZH0r8D932SHCVN
tXHtEghnQdoml8HwRY3LzqW2RWoC00drYg3wO8+B0VyXY3vcgYW7HfoU0YcFxyXg
5dsQq0MPa0gZ9Osz+DZTxAFOzvHIP+IKYqOkxkeJHKyZQ2tqYhiyelLqCa+n/wn0
I0CCyqrVcP3KQLgPs86kX5Z1Bj28VUtFBKu1GBAqo5wVaP3MvjKlEw8zXMTl24Gq
DALBaoBT7CppqpuMrupGswnVORZeLnTDKJIRPki8WyGxcyjxuQapAQ==
=kczn
-----END PGP SIGNATURE-----

--=-gfvttDL9ZpeaLnunfk8g--

