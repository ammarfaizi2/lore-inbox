Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262633AbTCIVOp>; Sun, 9 Mar 2003 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262634AbTCIVOp>; Sun, 9 Mar 2003 16:14:45 -0500
Received: from dvmwest.gt.owl.de ([62.52.24.140]:19210 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S262633AbTCIVOn>;
	Sun, 9 Mar 2003 16:14:43 -0500
Date: Sun, 9 Mar 2003 22:25:22 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: patching the kernel
Message-ID: <20030309212521.GQ27794@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200303091711.21652.jbriggs@briggsmedia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gl2oMwHnV9aOxBMt"
Content-Disposition: inline
In-Reply-To: <200303091711.21652.jbriggs@briggsmedia.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Gl2oMwHnV9aOxBMt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2003-03-09 17:11:21 -0500, joe briggs <jbriggs@briggsmedia.com>
wrote in message <200303091711.21652.jbriggs@briggsmedia.com>:
> My apologies for this question that is so basic to all of you, but can an=
y of=20
> you please point me toward a howto or instructions for exactly how to 'pa=
tch=20
> a kernel'?  For example, at kernel.org, the latest stable kernel is 2.4.2=
0,=20
> and is actually a patch.  I currently use 2.4.19 under Debian and routine=
ly=20
> rebuild & install it no problem.  If I download a kernel 'patch', do I ap=
ply=20
> it to the entire directory, or the compiled kernel, etc.?  Thanks so much.

	tar xzf .../linux-2.4.19.tar.gz
		-or-
	tar xjf .../linux-2.4.19.tar.bz2

and then apply the patch:

	cd linux-2.4.19
	zcat .../patch-2.4.20.gz | patch -p1
		-or-
	bzcat .../patch-2.4.20.bz2 | patch -p1

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--Gl2oMwHnV9aOxBMt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+a7FBHb1edYOZ4bsRAmXdAJ9kjTVFdUFGQzJnQtNq4IEcCndw7wCghoEx
Y8HwUnSHoj9SvtTWPjmiq1I=
=gMvF
-----END PGP SIGNATURE-----

--Gl2oMwHnV9aOxBMt--
