Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263760AbTB0LKz>; Thu, 27 Feb 2003 06:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbTB0LKz>; Thu, 27 Feb 2003 06:10:55 -0500
Received: from host217-36-80-42.in-addr.btopenworld.com ([217.36.80.42]:51086
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S263760AbTB0LKy>; Thu, 27 Feb 2003 06:10:54 -0500
Subject: Re: [Lse-tech] [PATCH] New dcache / inode hash tuning patch
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, lse-tech@projects.sourceforge.net,
       akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030226183304.GA30836@wotan.suse.de>
References: <20030226164904.GA21342@wotan.suse.de>
	<15730000.1046283789@[10.10.2.4]>  <20030226183304.GA30836@wotan.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Dh21LWUskF5n8nImmuj/"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Feb 2003 11:21:38 +0000
Message-Id: <1046344898.28559.12.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Dh21LWUskF5n8nImmuj/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-02-26 at 18:33, Andi Kleen wrote:
> On Wed, Feb 26, 2003 at 10:23:09AM -0800, Martin J. Bligh wrote:
> > It actually seems a fraction slower (see systimes for Kernbench-16,
> > for instance).
>=20
> Can you play a bit with the hash table sizes? Perhaps double the=20
> dcache hash and half the inode hash ?
>=20
> I suspect it really just needs a better hash function. I'll cook
> something up based on FNV hash.

Didn't wli do some work in this area? I seem to recall him recommending
FNV1a for dcache...

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-Dh21LWUskF5n8nImmuj/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+XfTBkbV2aYZGvn0RAlBgAJ4mYUBc9M3SdbqrlLBuhq99R4Sl8gCfaWXk
FMwFo0DUDPy/kgJdbi7AtNw=
=dyUD
-----END PGP SIGNATURE-----

--=-Dh21LWUskF5n8nImmuj/--

