Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSJJLIN>; Thu, 10 Oct 2002 07:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263369AbSJJLIN>; Thu, 10 Oct 2002 07:08:13 -0400
Received: from host213-121-110-54.in-addr.btopenworld.com ([213.121.110.54]:18851
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S263215AbSJJLIM>; Thu, 10 Oct 2002 07:08:12 -0400
Subject: Re: bondind 6 NICs
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: KELEMEN Peter <fuji@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021009205843.GA20614@chiara.elte.hu>
References: <20021009204920.6F0B74483@sitemail.everyone.net>
	 <20021009205843.GA20614@chiara.elte.hu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-vBq78c05EYzoBwxKeNCh"
Organization: 
Message-Id: <1034248455.1490.79.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 10 Oct 2002 12:14:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-vBq78c05EYzoBwxKeNCh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-10-09 at 21:58, KELEMEN Peter wrote:
> * Dionysio Calucci (dionysio@vr-zone.com) [20021009 13:49]:
>=20
> > i achieved in bonding four NICs in every computer, but i cannot
> > bond six NICs. The computer boots OK but it freezes when i start
> > using the network.
>=20
> That's actually much further than I managed.  2.4.19 completely
> freezes when configuring the bonding interface (bond0), only power
> cycle helps.  I'm trying to bond two 3Com Vortex cards together.

try this patch taken from 2.4.20-preX

http://www.scaramanga.co.uk/kernel/ECSC-2.4.19/02_bonding-fixes.diff.gz

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-vBq78c05EYzoBwxKeNCh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9pWEHkbV2aYZGvn0RAkW1AJ9yLRFufRe97ABx5OeZE18JgmrUQwCeK2OJ
84dAYfNEill88ahvy9QnRTw=
=VlPE
-----END PGP SIGNATURE-----

--=-vBq78c05EYzoBwxKeNCh--

