Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbUKUCVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbUKUCVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUKUCVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:21:20 -0500
Received: from natnoddy.rzone.de ([81.169.145.166]:42956 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S261745AbUKUCVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 21:21:16 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 3/13] Filesystem in Userspace
Date: Sun, 21 Nov 2004 03:14:58 +0100
User-Agent: KMail/1.6.2
Cc: diegocg@gmail.com, linux-kernel@vger.kernel.org
References: <E1CVeML-0007PA-00@dorka.pomaz.szeredi.hu> <20041121003755.3342a1cb.diegocg@gmail.com> <E1CVfgb-0007Ze-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1CVfgb-0007Ze-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_jo/nB3xv9iXxToz";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200411210314.59537.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_jo/nB3xv9iXxToz
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On S=FCnndag 21 November 2004 01:34, Miklos Szeredi wrote:
> > If something it's in mainline "kernel version 2.6.56" is enought to des=
cribe
> > what code people are running.
>=20
> It's not for people, but for the library. =A0It's the version of the
> userspace-kernel interface.
>=20
But once it is integrated, you can no longer make incompatible changes to
the API. You only need to know the difference between each API version
prior to the inclusion and the final version.

If the API gets extended later, any user should be able to deal with the
extension failing on older kernels.

	Arnd <><

--Boundary-02=_jo/nB3xv9iXxToz
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBn/oj5t5GS2LDRf4RAiUPAJ48t2akOPHlBxtOlqokWR5oqQVQOQCgkW2E
9AsNR6Tbk5yFj3Ca6nBQzyc=
=WB2J
-----END PGP SIGNATURE-----

--Boundary-02=_jo/nB3xv9iXxToz--
