Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLAVqL>; Sun, 1 Dec 2002 16:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262662AbSLAVqL>; Sun, 1 Dec 2002 16:46:11 -0500
Received: from dialin-145-254-148-098.arcor-ip.net ([145.254.148.98]:5762 "HELO
	schottelius.net") by vger.kernel.org with SMTP id <S262580AbSLAVqK>;
	Sun, 1 Dec 2002 16:46:10 -0500
Date: Sun, 1 Dec 2002 22:52:08 +0100
From: Nico Schottelius <schottelius@wdt.de>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PCMCIA <dhinds@zen.stanford.edu>
Subject: Re: [BUGS 2.5.45]
Message-ID: <20021201215208.GM338@schottelius.org>
References: <20021107090425.GA461@schottelius.org> <20021201144232.GC3098@conectiva.com.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="va9XEZk9/dJ5GUjX"
Content-Disposition: inline
In-Reply-To: <20021201144232.GC3098@conectiva.com.br>
User-Agent: Mutt/1.4i
X-Operating-System: Linux flapp 2.4.19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--va9XEZk9/dJ5GUjX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Arnaldo Carvalho de Melo [Sun, Dec 01, 2002 at 12:42:32PM -0200]:
> Em Sun, Dec 01, 2002 at 03:31:26PM +0100, Nico Schottelius escreveu:
> > Hello again!
>=20
> 2.5.45 is too old, could you try 2.5.50 instead? Anyway, some comments:

I am sorry, my mail was delayed. I am trying 2.5.50 currently. =20
 =20
> > 2) PCMCIA module ds.o cannot be loaded -> somehow the kernel denies tha=
t.
>=20
> Perhaps related to Rusty's work on the in-kernel module loader

in fact, 2.5.50 loads ds.o fine again!
there seem still be some problems with some modules, but I think
this will be fixed soon.
 =20
> > 3) atimach64 console driver makes blank screen on 01:00.0 VGA compatible
> > controller: ATI Technologies Inc 3D Rage P/M Mobilit=3D y AGP 2x (rev 6=
4)
>=20
> The fb code needs a merge with James Simmons tree, it seems to be planned=
 to
> happen soon.

Right now I am subscribed to fbdev list, hopefully they'll merge soon.
I tried aty/aty128fb some months ago with the same result..

Nico

--=20
Please send your messages pgp-signed and/or pgp-encrypted (don't encrypt ma=
ils
to mailing list!). If you don't know what pgp is visit www.gnupg.org.
(public pgp key: ftp.schottelius.org/pub/familiy/nico/pgp-key)

--va9XEZk9/dJ5GUjX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE96oSItnlUggLJsX0RAiqwAKCLiBEfPyXY4QiQrUZXjtbGRxxisACfb5L/
h5Xww+vGcQXJzGd0VTJ/f60=
=pbpw
-----END PGP SIGNATURE-----

--va9XEZk9/dJ5GUjX--
