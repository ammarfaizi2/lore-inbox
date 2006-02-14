Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbWBNIhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWBNIhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 03:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbWBNIhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 03:37:33 -0500
Received: from smtp2.pp.htv.fi ([213.243.153.35]:42464 "EHLO smtp2.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932376AbWBNIhc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 03:37:32 -0500
Date: Tue, 14 Feb 2006 10:37:29 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Cc: kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: [2.6 patch] arch/sh/Kconfig: fix the ISA_DMA_API dependencies
Message-ID: <20060214083729.GA32389@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	kkojima@rr.iij4u.or.jp, linuxsh-dev@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Jean-Luc Leger <reiga@dspnet.fr.eu.org>
References: <20060214002203.GC17604@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <20060214002203.GC17604@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 14, 2006 at 01:22:04AM +0100, Adrian Bunk wrote:
> Jean-Luc Leger <reiga@dspnet.fr.eu.org> found this obvious typo.
>=20
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>=20
Acked-by: Paul Mundt <lethal@linux-sh.org>

> --- linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig.old	2006-02-14 01:18:22.000=
000000 +0100
> +++ linux-2.6.16-rc2-mm1-full/arch/sh/Kconfig	2006-02-14 01:19:43.0000000=
00 +0100
> @@ -446,7 +446,7 @@
> =20
>  config ISA_DMA_API
>  	bool
> -	depends on MPC1211
> +	depends on SH_MPC1211
>  	default y
> =20
>  menu "Kernel features"
>=20

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD8ZbI1K+teJFxZ9wRAsS8AKCEiXgnUskv+v93O8RHwQOrjezthACfeTNq
a3XPRs4jETq9aD/isJPtkbs=
=Vj4H
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
