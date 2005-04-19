Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVDSOXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVDSOXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 10:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbVDSOXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 10:23:39 -0400
Received: from dea.vocord.ru ([217.67.177.50]:40884 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261553AbVDSOXQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 10:23:16 -0400
Subject: Re: [2.6 patch] drivers/w1/: possible cleanups
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050417233145.GX3625@stusta.de>
References: <20050417233145.GX3625@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-27dxQGlgP/S1Jqwc8mDK"
Organization: MIPT
Date: Tue, 19 Apr 2005 18:26:27 +0400
Message-Id: <1113920787.29655.11.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 19 Apr 2005 18:19:17 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-27dxQGlgP/S1Jqwc8mDK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-04-18 at 01:31 +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 unused functions
> - remove unused EXPORT_SYMBOL's
>=20
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thank you for your patch, I will apply the most of it,
but I have some points against
1. removing ->get(), while having ->put() methods.
2. removing some w1_read/write* methods() since they are used for test
cases.

I will push it after Greg applied current pending patchset.

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-27dxQGlgP/S1Jqwc8mDK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCZRUTIKTPhE+8wY0RAnmOAKCNDMT0ACJtLTB5gDNgpfS5t43A1wCeKhZ2
27esBy+01o+NN+21+RknGS8=
=KnZ/
-----END PGP SIGNATURE-----

--=-27dxQGlgP/S1Jqwc8mDK--

