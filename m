Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266643AbUIANtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266643AbUIANtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 09:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267401AbUIANrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 09:47:11 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:26761 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266646AbUIANno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 09:43:44 -0400
Date: Wed, 1 Sep 2004 15:43:41 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Christoph Hellwig <hch@lst.de>
Subject: Re: kbuild: Support LOCALVERSION
Message-ID: <20040901134341.GT6985@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, Ian Wienand <ianw@gelato.unsw.edu.au>,
	Christoph Hellwig <hch@lst.de>
References: <20040831192642.GA15855@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nx8xdmI2KD3LNVVP"
Content-Disposition: inline
In-Reply-To: <20040831192642.GA15855@mars.ravnborg.org>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nx8xdmI2KD3LNVVP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-08-31 21:26:43 +0200, Sam Ravnborg <sam@ravnborg.org>
wrote in message <20040831192642.GA15855@mars.ravnborg.org>:
> The following patch combines the request from several people.
> If you place a file named localversion* in the root of your
> soruce tree or the root of your output tree the text included in this
> file will be appended to KERNELRELEASE.
>=20
> LOCALVERSION was originally introduced by Ian Wienand <ianw@gelato.unsw.e=
du.au>
>=20
> This allows one to put a short string in localversion identifying this
> particular configuration "-smpacpi", or to identify applied patches
> to the source "-llat-np".
>=20
> More specifically:
> $(srctree)/localversion-lowlatency contains "-llat"
> $(srctree)/localversion-scheduler-nick constins "-np"
>=20
> $(objtree)/localversion contains "-smpacpi"
>=20
> Resulting KERNELRELEASE would be:
> 2.6.8.rc1-smpacpi-llat-np

Basically: I love it. Maybe it would also be good (in the longer term)
to introduce a config name into one of the Kconfig files, which is
preserved in the .config file (eg. SuSE does something like that and
even while I'm not a SuSE user, it's really dandy at some times, esp.
for things like "SMP-4GB", "VAX-KA4x" and the like). It's basically like
adding the defconfig_* name to some of the variables :-)

MfG, JBG
PS: When will the package support show up?

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Nx8xdmI2KD3LNVVP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBNdINHb1edYOZ4bsRApdWAJ4gguWGD/Iag6RXwOmv9+sDwXEYRgCfSyyd
aU2B/PTTzQldFem+XVo9/i8=
=Sxr4
-----END PGP SIGNATURE-----

--Nx8xdmI2KD3LNVVP--
