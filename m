Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSH0UlY>; Tue, 27 Aug 2002 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317107AbSH0UlY>; Tue, 27 Aug 2002 16:41:24 -0400
Received: from ppp-217-133-221-79.dialup.tiscali.it ([217.133.221.79]:60108
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317091AbSH0UlX>; Tue, 27 Aug 2002 16:41:23 -0400
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
From: Luca Barbieri <ldb@ldb.ods.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+fyxyEv1+wipM/Ld/Wa6"
X-Mailer: Ximian Evolution 1.0.5 
Date: 27 Aug 2002 22:45:29 +0200
Message-Id: <1030481129.6203.3.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+fyxyEv1+wipM/Ld/Wa6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> There's another issue, which is the fact that I do not believe that invlpg 
> is even guaranteed to invalidate a G page at all - although obviously all 
> current CPU's seem to work that way. However, I don't see that documented 
> anywhere.
You haven't read the P4 system architecture manual, section 3.11.
It explicitly says that invlpg ignores the G flag.


--=-+fyxyEv1+wipM/Ld/Wa6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9a+Tpdjkty3ft5+cRAqB4AJ4luCRj55sPrngbvtVLgHfeowaWZACfbUv4
ahy/vrMcz/Qa/vOUMSweTrE=
=Xutp
-----END PGP SIGNATURE-----

--=-+fyxyEv1+wipM/Ld/Wa6--
