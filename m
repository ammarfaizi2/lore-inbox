Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263125AbTCYSQk>; Tue, 25 Mar 2003 13:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263174AbTCYSQk>; Tue, 25 Mar 2003 13:16:40 -0500
Received: from iucha.net ([209.98.146.184]:22381 "EHLO mail.iucha.net")
	by vger.kernel.org with ESMTP id <S263125AbTCYSQh>;
	Tue, 25 Mar 2003 13:16:37 -0500
Date: Tue, 25 Mar 2003 12:27:46 -0600
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Framebuffer updates.
Message-ID: <20030325182746.GA8769@iucha.net>
References: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303251032320.4272-100000@maxwell.earthlink.net>
X-message-flag: Outlook: Where do you want [your files] to go today?
X-gpg-key: http://iucha.net/florin_iucha.gpg
X-gpg-fingerprint: 41A9 2BDE 8E11 F1C5 87A6  03EE 34B3 E075 3B90 DFE4
User-Agent: Mutt/1.5.3i
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2003 at 05:57:18PM +0000, James Simmons wrote:
>=20
> As usually I have a patch avalaible at=20
>=20
> http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz
>=20
>  drivers/video/aty/aty128fb.c  |   16 +++++++---------
>  drivers/video/console/fbcon.c |    4 ++--
>  drivers/video/controlfb.c     |   18 +++---------------
>  drivers/video/platinumfb.c    |   28 ++++++++--------------------
>  drivers/video/radeonfb.c      |   10 ++++++++++
>  drivers/video/softcursor.c    |    2 +-
>  6 files changed, 31 insertions(+), 47 deletions(-)
>=20
> The patch has updates for the ATI Rage 128, Control, and Platnium=20
> framebuffer driver. The Radeon patch adds PLL times for the R* series of
> cards. Memory is now safe to allocate for the software cursor and inside=
=20
> fbcon. There still are issues with syncing which cause the cursor on some=
=20
> systems to become corrupt sometimes.=20

Where can I find working "modelines" for Radeon 8500?

I have a=20
   radeonfb: ATI Radeon 8500 QL DDR SGRAM 64 MB

I am interested in 1024x768 and 1152x864. I have tried the defaults
that come with Debian fbset (2.1-8) but I get garbled screen upon
changing the video mode. I can 'clear' the console and work more or
less normally but the viewport will be just a part of the whole
screen.

Thanks,
florin

--=20

"NT is to UNIX what a doughnut is to a particle accelerator."

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gJ+iNLPgdTuQ3+QRAtAIAKCLj0hZ5b6YDf2Yk/wR2Y+P+LE1egCfS4ck
+wLk2S8jQHwZdSrg++HVfpM=
=A64A
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
