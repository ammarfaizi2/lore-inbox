Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbUKVQmZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbUKVQmZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 11:42:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKVQlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 11:41:44 -0500
Received: from dea.vocord.ru ([217.67.177.50]:60893 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262171AbUKVQSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 11:18:06 -0500
Subject: Re: [2.6 patch] make W1_DS9490_BRIDGE available
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041122155102.GD19419@stusta.de>
References: <20041122155102.GD19419@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-QCw94crsqehOnC43QYWf"
Organization: MIPT
Date: Mon, 22 Nov 2004 19:20:56 +0300
Message-Id: <1101140456.9784.0.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 22 Nov 2004 16:16:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QCw94crsqehOnC43QYWf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 16:51 +0100, Adrian Bunk wrote:
> It seems noone noted that due to a typo, the W1_DS9490_BRIDGE option=20
> didn't have any effect.

hugh, you are right.
I have applied it to my tree, thank you.

>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
> --- linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig.old	2004-11-22 14:34:13.=
000000000 +0100
> +++ linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig	2004-11-22 14:34:21.0000=
00000 +0100
> @@ -30,7 +30,7 @@
>  	  This support is also available as a module.  If so, the module=20
>  	  will be called ds9490r.ko.
> =20
> -config W1_DS9490R_BRIDGE
> +config W1_DS9490_BRIDGE
>  	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
>  	depends on W1_DS9490
>  	help
--=20

--=-QCw94crsqehOnC43QYWf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBohHnIKTPhE+8wY0RAgnBAJ4lpXLL01/5xC79c5u05mGwZFbHFgCgkRfI
IGiPY/afa0vi11LGlNj6tFQ=
=ogmx
-----END PGP SIGNATURE-----

--=-QCw94crsqehOnC43QYWf--

