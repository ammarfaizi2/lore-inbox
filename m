Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbVBKBLW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbVBKBLW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 20:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVBKBLW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 20:11:22 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:29398 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261991AbVBKBLK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 20:11:10 -0500
From: Mws <mws@twisted-brains.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: DVB at76c651.c driver seems to be dead code
Date: Fri, 11 Feb 2005 02:11:17 +0100
User-Agent: KMail/1.7.92
Cc: Andreas Oberritter <obi@linuxtv.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
References: <20050210235605.GN2958@stusta.de>
In-Reply-To: <20050210235605.GN2958@stusta.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4350710.X30OrqjXrh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502110211.29055.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4350710.X30OrqjXrh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 11 February 2005 00:56, Adrian Bunk wrote:
> I didn't find any way how the drivers/media/dvb/frontends/at76c651.c=20
> driver would do anything inside kernel 2.6.11-rc3-mm2. All it does is to=
=20
> EXPORT_SYMBOL a function at76c651_attach that isn't used anywhere.
>=20
> Is a patch to remove this driver OK or did I miss anything?
>=20
> cu
> Adrian
>=20
=46YI

The atmel at76c651 frontend driver is used for the=20
Sagem DBox2 Digital Cable Receiver.=20

As all other parts of the dbox2 drivers are atm not hosted at kernel cvs bu=
t at
cvs.tuxbox.org you won't find any components in mainline kernel tree using =
this.

thus we are a hobby project - but even well known - there are not so many d=
eveloper
available to make every kernel driver and other parts of it "kernel-style-a=
like".=20
maybe there is more progress and kernel driver patching into mainline in th=
e future.
we are having 2.6.9 running on dbox2 - higher versions are atm broken for s=
upport of
the mpc 823 architecture :/

removing this driver is not wanted.

regards
Marcel Siegert
mws@tuxbox.org




--nextPart4350710.X30OrqjXrh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCDAZBPpA+SyJsko8RAupbAKDNjks8xYLBgYeWlEdDJ/xL+TMzxgCfUQkQ
FB8zrosDC9/8QWlHTnbBCoc=
=R30y
-----END PGP SIGNATURE-----

--nextPart4350710.X30OrqjXrh--
