Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUF1JaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUF1JaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 05:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUF1JaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 05:30:21 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:10976 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S264635AbUF1JaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 05:30:14 -0400
Date: Mon, 28 Jun 2004 11:30:13 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Breaking ext2 file size limit of 2TB
Message-ID: <20040628093013.GR20632@lug-owl.de>
Mail-Followup-To: Goldwyn Rodrigues <goldwyn_r@myrealbox.com>,
	linux-kernel@vger.kernel.org
References: <1088406721.9804291cgoldwyn_r@myrealbox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1reTD/IpU+i0LMng"
Content-Disposition: inline
In-Reply-To: <1088406721.9804291cgoldwyn_r@myrealbox.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1reTD/IpU+i0LMng
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-28 12:42:01 +0530, Goldwyn Rodrigues <goldwyn_r@myrealbox.c=
om>
wrote in message <1088406721.9804291cgoldwyn_r@myrealbox.com>:
> > With an unpatched version you would not be able to create a file
> >> greater than 2TB at all and considers that all files are below 2TB.
> > Sounds like an incompatible extension, so you need to mark it as one:)
>=20
> I am working on the COMPAT fields now. Most probably, I will be able to g=
ive Read only access. I have to study more on this.

Just check if there's any code path that could clear your high-bits of
the block counter.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--1reTD/IpU+i0LMng
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3+UkHb1edYOZ4bsRAmcoAJ4m0hLWonTNVzluB4IPd9DQtoOPhwCdGWHu
ms5cDJm3K6ab6OUYXM/gWSA=
=6y8x
-----END PGP SIGNATURE-----

--1reTD/IpU+i0LMng--
