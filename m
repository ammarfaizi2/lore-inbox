Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261604AbSJIMYy>; Wed, 9 Oct 2002 08:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261617AbSJIMYy>; Wed, 9 Oct 2002 08:24:54 -0400
Received: from host213-121-105-39.in-addr.btopenworld.com ([213.121.105.39]:6802
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S261604AbSJIMYx>; Wed, 9 Oct 2002 08:24:53 -0400
Subject: Re: [patch] tcp connection tracking 2.4.19
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Martin Renold <martinxyz@gmx.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3DA348EF.7060709@drugphish.ch>
References: <20021008205053.GA2621@old.homeip.net>
	 <3DA348EF.7060709@drugphish.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ngVJRBBZ8jPe0UHP9+ml"
Organization: 
Message-Id: <1034166655.30384.13.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 09 Oct 2002 13:30:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ngVJRBBZ8jPe0UHP9+ml
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-10-08 at 22:06, Roberto Nibali wrote:
> Welcome to the world of almost-stateful packet filtering. Hey, other=20
> than that, the 3wahas 'exploit' is old. Also don't I understand why they=20
> claim that SYN cookies prevent syn flooding. Next time you meet someone=20
> of the guys, tell them about the backlog queue.
>=20

"When syncookies are enabled the packets are still answered  and  this
value [tcp_max_syn_backlog] is effectively ignored." -- From tcp(7)
manpage.

The whole point of syncookies is to negate the need for a backlog queue.

Or did I miss your point?

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-ngVJRBBZ8jPe0UHP9+ml
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9pCF/kbV2aYZGvn0RAmmLAJ9x//QrNXuDU57xrvKfUdHa6bT/aQCePVbh
AsK2Cvm0GgTjI6oyd3NL2b8=
=Nq9t
-----END PGP SIGNATURE-----

--=-ngVJRBBZ8jPe0UHP9+ml--

