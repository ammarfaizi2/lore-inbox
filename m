Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTB0WDY>; Thu, 27 Feb 2003 17:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTB0WDX>; Thu, 27 Feb 2003 17:03:23 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54149 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267137AbTB0WDW>; Thu, 27 Feb 2003 17:03:22 -0500
Message-Id: <200302272213.h1RMDQJT017937@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts 
In-Reply-To: Your message of "Thu, 27 Feb 2003 20:47:05 +0100."
             <3E5E6B39.3DD1C6A@daimi.au.dk> 
From: Valdis.Kletnieks@vt.edu
References: <200302271600.h1RG0Cdh011948@eeyore.valparaiso.cl> <200302271740.06139.dominik@kubla.de>
            <3E5E6B39.3DD1C6A@daimi.au.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1450773806P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 17:13:26 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1450773806P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Feb 2003 20:47:05 +0100, Kasper Dupont said:

> mnttab report in those cases? And while we are discussing bind mounts, =
there
> is one feature that I have sometimes missed: A possibility to directly =
mount
> a subdirectory of a filesystem without having to mount the root of that=

> filesystem first and use a bindmount afterwards.

Hmm.. so what you mean is being able to have a filesystem called (for exa=
mple)
/somewhere, and being able to mount /somewhere/deep/path/like/this on a
mountpoint /wherever/else, but without having /somewhere mounted itself?
That looks *almost* doable, except that things like quotas or the free
block list would be a hassle if then you also went and mounted
/somewhere/deep/other/path on /something/else

Or did you want to do 'mount /somewhere/deep /wherever/else' when it's
/wherever that isn't actually mounted?  This looks more.. umm.. interesti=
ng,
as you could (for instance) use an automounter to mount /home/fred, /home=
/george
/home/sally, and not actually need a /home?  But don't current automounte=
rs
almost do this already?
-- =

				Valdis Kletnieks
				Computer Systems Senior Engineer
				Virginia Tech


--==_Exmh_1450773806P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+Xo2GcC3lWbTT17ARAhgXAKCsqGPv42CwiMEaD9rK2A25OKgiMgCgneVp
fDZqOCdqrZDa1wUIW5/eOnU=
=UrGX
-----END PGP SIGNATURE-----

--==_Exmh_1450773806P--
