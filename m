Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317685AbSGVQ0V>; Mon, 22 Jul 2002 12:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317698AbSGVQ0V>; Mon, 22 Jul 2002 12:26:21 -0400
Received: from B55e6.pppool.de ([213.7.85.230]:6924 "EHLO
	nicole.de.interearth.com") by vger.kernel.org with ESMTP
	id <S317685AbSGVQ0T>; Mon, 22 Jul 2002 12:26:19 -0400
Subject: Re: [PATCH] 2.5.27 sysctl
From: Daniel Egger <degger@fhm.edu>
To: martin@dalecki.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3D3BE17F.3040905@evision.ag>
References: <Pine.LNX.4.44.0207201218390.1230-100000@home.transmeta.com> 
	<3D3BE17F.3040905@evision.ag>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-+ay7bewcEc06lRTXtQtS"
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jul 2002 17:57:09 +0200
Message-Id: <1027353430.5955.5.camel@sonja.de.interearth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+ay7bewcEc06lRTXtQtS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Am Mon, 2002-07-22 um 12.42 schrieb Marcin Dalecki:

> diff -urN linux-2.5.27/include/linux/sysctl.h linux/include/linux/sysctl.=
h
> --- linux-2.5.27/include/linux/sysctl.h	2002-07-20 21:11:05.000000000 +02=
00
> +++ linux/include/linux/sysctl.h	2002-07-21 19:30:43.000000000 +0200
> @@ -126,7 +126,7 @@
>  	KERN_S390_USER_DEBUG_LOGGING=3D51,  /* int: dumps of user faults */
>  	KERN_CORE_USES_PID=3D52,		/* int: use core or core.%pid */
>  	KERN_TAINTED=3D53,	/* int: various kernel tainted flags */
> -	KERN_CADPID=3D54,		/* int: PID of the process to notify on CAD */
> +	KERN_CADPID=3D54		/* int: PID of the process to notify on CAD */
>  };

Please don't do such changes, there's a reason for the trailing comma:
Making it easier to extend structures and enums.

--=20
Servus,
       Daniel

--=-+ay7bewcEc06lRTXtQtS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9PCtVchlzsq9KoIYRAilGAJ9k5VILkVYMvvBHYo5tlB/4Yw5S9gCgtZyF
UDAQYltPwqZVsHODWU05GYs=
=NXfL
-----END PGP SIGNATURE-----

--=-+ay7bewcEc06lRTXtQtS--

