Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTICPPr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTICPPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:15:46 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:42929 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263440AbTICPPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:15:33 -0400
Date: Wed, 3 Sep 2003 17:15:32 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Compiling latest 2.6 bk snapshot on Alpha
Message-ID: <20030903151532.GH14376@lug-owl.de>
Mail-Followup-To: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20030903143157.GA17699@localhost> <wrpznhm3pgg.fsf@hina.wild-wind.fr.eu.org> <20030903150024.GA18306@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WGtO2LJjz4IIGa2c"
Content-Disposition: inline
In-Reply-To: <20030903150024.GA18306@localhost>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WGtO2LJjz4IIGa2c
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-09-03 11:00:24 -0400, Mathieu Chouquet-Stringer <mchouque@onli=
ne.fr>
wrote in message <20030903150024.GA18306@localhost>:
> On Wed, Sep 03, 2003 at 04:40:31PM +0200, Marc Zyngier wrote:
> > Please check your binutils version. Here is the one I use, with great
> > success :
> >=20
> > maz@panther:/mnt/i386/linux-2.5$ alpha-linux-ld --version
> > GNU ld version 2.13.90.0.18 20030121
>=20
> Mine is: GNU ld version 2.14.90.0.5 20030722 Debian GNU/Linux

I've just started a compile run with exactly this ld and gcc-3.3.2
20030812. This may take a while (it's a 166MHz NoName...).

Maybe you've simply created a too large kernel image. Have you compiled
many features into the kernel (where modules would have worked also...)?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--WGtO2LJjz4IIGa2c
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/VgWUHb1edYOZ4bsRAjiQAJwPcljcuMs7QbmVXKi9ArNKSveqFQCeKTIm
AIa3v2/B51zTdi4MHaFTEFw=
=SLj2
-----END PGP SIGNATURE-----

--WGtO2LJjz4IIGa2c--
