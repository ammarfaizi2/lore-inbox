Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTGCLxM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 07:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265145AbTGCLxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 07:53:12 -0400
Received: from M973P026.adsl.highway.telekom.at ([62.47.153.154]:26753 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S265153AbTGCLxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 07:53:09 -0400
Date: Thu, 3 Jul 2003 14:04:04 +0200
From: maximilian attems <maks@sternwelten.at>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org,
       Thomas Winischhofer <thomas@winischhofer.net>
Subject: Re: [2.5 patch] move an unused variable in sis_main.c
Message-ID: <20030703120404.GC939@mail.sternwelten.at>
References: <20030703104700.GA939@mail.sternwelten.at> <20030703114726.GK282@fs.tum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <20030703114726.GK282@fs.tum.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, 03 Jul 2003, Adrian Bunk wrote:

>=20
> If TWDEBUG does anything your patch breaks the compilation on kernel 2.4=
=20
> with gcc 2.95 .
>=20
>=20


thx for your attention but
TWDEBUG is defined in drivers/video/sis/sis.h

#if 1
#define TWDEBUG(x)
#else
#define TWDEBUG(x) printk(KERN_INFO x "\n");
#endif

please correct me if it breaks one of this macros
maks



--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/BBu06//kSTNjoX0RAk/0AJoC3sUgYmj/d0kUInJn92VeNtLarQCggpSg
1+kfVK4lTjjJv9DqFltKEgM=
=fPev
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
