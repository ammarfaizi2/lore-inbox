Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbUKVH2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUKVH2O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 02:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUKVH2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 02:28:14 -0500
Received: from dea.vocord.ru ([217.67.177.50]:27082 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S261902AbUKVH2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 02:28:09 -0500
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041121220251.GE13254@stusta.de>
References: <20041121220251.GE13254@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OzWaxGacFHuJpqF8iK+4"
Organization: MIPT
Message-Id: <1101108672.2843.55.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 22 Nov 2004 10:31:12 +0300
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Mon, 22 Nov 2004 07:26:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OzWaxGacFHuJpqF8iK+4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-22 at 01:02, Adrian Bunk wrote:
> Hi Evgeniy,

Hello, Adrian.

> drivers/w1/Makefile in recent 2.6 kernels contains:
>   obj-$(CONFIG_W1_DS9490)         +=3D ds9490r.o=20
>   ds9490r-objs    :=3D dscore.o
>=20
> Is there a reason, why dscore.c isn't simply named ds9490r.c ?

dscore.c is a core function set to work with ds2490 chip.
ds9490* is built on top of it.
Any vendor can create it's own w1 bus master using this chip,=20
not ds9490.


> TIA
> Adrian
--=20
	Evgeniy Polyakov

Crash is better than data corruption. -- Art Grabowski

--=-OzWaxGacFHuJpqF8iK+4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBoZXAIKTPhE+8wY0RAtKKAJkB3wXmzib3RzSLwHFOsHkXQZIVIgCeOoCG
DVCwX83/rK3/milnMibGfEw=
=Ym3b
-----END PGP SIGNATURE-----

--=-OzWaxGacFHuJpqF8iK+4--

