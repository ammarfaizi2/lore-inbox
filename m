Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267792AbUI1Oey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267792AbUI1Oey (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 10:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267860AbUI1Oey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 10:34:54 -0400
Received: from moutng.kundenserver.de ([212.227.126.191]:763 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S267792AbUI1Oc0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 10:32:26 -0400
Date: Tue, 28 Sep 2004 16:32:11 +0200
From: Sven Schuster <schuster.sven@gmx.de>
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       Michal Ludvig <michal@logix.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc2 2/2] cryptoapi: make /proc/crypto optional
Message-ID: <20040928143211.GA18136@zion.homelinux.com>
References: <20040927084149.GA3625@final-judgement.ath.cx> <Xine.LNX.4.44.0409271151500.21876-100000@thoron.boston.redhat.com> <20040928122117.GA21010@final-judgement.ath.cx> <20040928122332.GB21010@final-judgement.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <20040928122332.GB21010@final-judgement.ath.cx>
User-Agent: Mutt/1.5.6i
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:38b5f051b8cd178556c5593940405c4a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Andreas,

just one little thing I noticed:

On Tue, Sep 28, 2004 at 02:23:32PM +0200, Andreas Happe told us:
> diff -u -r -N linux-2.6.8/crypto/Kconfig linux-sysfs/crypto/Kconfig
> --- linux-2.6.8/crypto/Kconfig	2004-09-28 12:50:31.000000000 +0200
> +++ linux-sysfs/crypto/Kconfig	2004-09-28 12:18:25.000000000 +0200
> @@ -16,6 +16,15 @@
>  	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
>  	  This is required for IPSec.
> =20
> +config CRYPTO_PROC
> +	bool "Legacy /proc/crypto interface (OBSOLETE)"
> +	depends on PROC_FS && CRYPTO
> +	help
> +	  Displays cipher specific information via /proc/crypto.
> +	  Please use /sysfs/class/crypto instead.
> +
> +	  When in double say Y.

In double?? Probably should be "in doubt"...


Sven

--=20
Linux zion 2.6.9-rc1-mm4 #1 Tue Sep 7 12:57:19 CEST 2004 i686 athlon i386 G=
NU/Linux
 16:31:14  up 2 days, 15:44,  3 users,  load average: 0.21, 0.07, 0.02

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBWXXro4FAdB2PneQRAkMcAJ4vkOjlq6Kr9bcoKZXYZadTlAFtZgCeLjoe
Mv12dpteUi8V2ZBcO2ERfPI=
=E0U8
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
