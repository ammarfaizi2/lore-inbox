Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318730AbSH1GOJ>; Wed, 28 Aug 2002 02:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318733AbSH1GOI>; Wed, 28 Aug 2002 02:14:08 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:6931 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S318730AbSH1GOI>;
	Wed, 28 Aug 2002 02:14:08 -0400
Date: Wed, 28 Aug 2002 08:18:27 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
Message-ID: <20020828061827.GB27967@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <Pine.LNX.4.33.0208271239580.2564-100000@penguin.transmeta.com> <20020827202250.GA24265@debian> <6e0.3d6be706.b5d05@gzp1.gzp.hu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <6e0.3d6be706.b5d05@gzp1.gzp.hu>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
x-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
x-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-08-27 20:54:30 -0000, Gabor Z. Papp <gzp@myhost.mynet>
wrote in message <6e0.3d6be706.b5d05@gzp1.gzp.hu>:
>   gcc -Wp,-MD,./.8250.o.d -D__KERNEL__ -I/usr/src/linux-2.5.32-gzp3/inclu=
de -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-s=
trict-aliasing -fno-common -pipe -mpreferred-stack-boundary=3D2 -march=3Di6=
86 -nostdinc -iwithprefix include -DMODULE -include /usr/src/linux-2.5.32-g=
zp3/include/linux/modversions.h   -DKBUILD_BASENAME=3D8250 -DEXPORT_SYMTAB =
 -c -o 8250.o 8250.c
> In file included from 8250.c:34:
> /usr/src/linux-2.5.32-gzp3/include/linux/serialP.h:50: field `icount' has=
 incomplete type

Header file problem. In serialP.h, right at the beginning, there's a
version check, which unfortunately is in wrong direction. No sources
available, no patch...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD4DBQE9bGszHb1edYOZ4bsRAiMBAJda9fwE/AqaC+Y+Pyudr4q/aFJ4AJ9ZEeRl
cddj1rj618wXbfrD5v8xKw==
=ako+
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
