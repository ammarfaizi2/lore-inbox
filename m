Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317232AbSIAPao>; Sun, 1 Sep 2002 11:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSIAPao>; Sun, 1 Sep 2002 11:30:44 -0400
Received: from ppp-217-133-221-133.dialup.tiscali.it ([217.133.221.133]:3553
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317191AbSIAPan>; Sun, 1 Sep 2002 11:30:43 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: trond.myklebust@fys.uio.no, Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E17lWRm-0004Zg-00@starship>
References: <Pine.LNX.4.44.0208311235110.1255-100000@home.transmeta.com>
	<15729.17279.474307.914587@charged.uio.no> <1030835635.1422.39.camel@ldb> 
	<E17lWRm-0004Zg-00@starship>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-rz8wKHGlFpt16YJmBSDQ"
X-Mailer: Ximian Evolution 1.0.5 
Date: 01 Sep 2002 17:35:03 +0200
Message-Id: <1030894503.2145.70.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rz8wKHGlFpt16YJmBSDQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> It is a serious concern.  Inventing new, subtle behavior differences 
> between user and kernel threads is, in a word, gross.  It's certain
> to bite people in the future.
So you are suggesting that it's better to slow down *all* threads so
that it's possible to have kernel threads with automatically shared
credentials?
BTW, signals and rescheduling (unless PREEMPT=y) don't work
automatically for the same reason.


--=-rz8wKHGlFpt16YJmBSDQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cjOndjkty3ft5+cRAi3JAJ9GQDR3lbjfzeu3ZSqli2Oqz3plkwCffU3D
PQRpE7GZGqRa/um3bjOtQy4=
=K9QS
-----END PGP SIGNATURE-----

--=-rz8wKHGlFpt16YJmBSDQ--
