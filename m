Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318034AbSHDPj7>; Sun, 4 Aug 2002 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318078AbSHDPj6>; Sun, 4 Aug 2002 11:39:58 -0400
Received: from ppp-217-133-220-178.dialup.tiscali.it ([217.133.220.178]:16332
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318034AbSHDPj6>; Sun, 4 Aug 2002 11:39:58 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Luca Barbieri <ldb@ldb.ods.org>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020804173245.1e3254f7.sebastian.droege@gmx.de>
References: <1028471237.1294.515.camel@ldb> 
	<20020804173245.1e3254f7.sebastian.droege@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-0j2s9Eb4CfjE6w3Ta7Gh"
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Aug 2002 17:43:23 +0200
Message-Id: <1028475803.1294.529.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0j2s9Eb4CfjE6w3Ta7Gh
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> is there really support for SSE prefetch in athlons _without_ SSE?!
> I don't know but this seems wrong...
Yes, according to
<http://www.amd.com/products/cpg/athlon/techdocs/pdf/22466.pdf>.
AMD added several intructions in Athlons including movntq, sfence and
prefetchnta/t0/t1/t2.
The last 4 instructions are what I call "SSE prefetch" (they could
called MMXEXT prefetch instead, but it's not much better).


--=-0j2s9Eb4CfjE6w3Ta7Gh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9TUubdjkty3ft5+cRAiQUAKDektyg1InXEXB1reKKupdk8X+xMgCg3Dd9
wlnb0FJ66T7jg778vuDD73k=
=VIe0
-----END PGP SIGNATURE-----

--=-0j2s9Eb4CfjE6w3Ta7Gh--
