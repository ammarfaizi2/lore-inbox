Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267579AbSKQUKd>; Sun, 17 Nov 2002 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267583AbSKQUKd>; Sun, 17 Nov 2002 15:10:33 -0500
Received: from ppp-217-133-221-200.dialup.tiscali.it ([217.133.221.200]:64395
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S267579AbSKQUJd>; Sun, 17 Nov 2002 15:09:33 -0500
Subject: Re: [patch] threading fix, tid-2.5.47-A3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0211172212001.18431-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-FJOfvXEdLOrHMod3mN4X"
X-Mailer: Ximian Evolution 1.0.8 
Date: 17 Nov 2002 21:16:06 +0100
Message-Id: <1037564166.1597.119.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FJOfvXEdLOrHMod3mN4X
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> we broke binary compatibility several times, for the benefit of having a
> cleaner interface. Ulrich has no problems with this approach and NPTL is
> the only user of these interfaces currently. But i think you are one of
> the few peoples who are running an NPTL system (ie. with the new
> NPTL-glibc actually installed as the default system glibc) - is binary
> compatibility important to you for this specific case?
No, but since I don't see any advantage in breaking it (other than a
more aesthetically pleasing header), why break it?
The problem is just the numbering of the flags, not the new
functionality.


--=-FJOfvXEdLOrHMod3mN4X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA91/kGdjkty3ft5+cRAgSUAKDDXjn9zfIAQn0GadrbHYfBogfuCACgkvb2
BIdtmLVlnKWagI/ypiIR2y0=
=93Sj
-----END PGP SIGNATURE-----

--=-FJOfvXEdLOrHMod3mN4X--
