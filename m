Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbTLKHQY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 02:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTLKHQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 02:16:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44966 "EHLO
	VL-MO-MR004.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S264384AbTLKHQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 02:16:10 -0500
Date: Thu, 11 Dec 2003 02:15:29 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: Increasing HZ (patch for HZ > 1000)
In-reply-to: <1288980000.1071126438@[10.10.2.4]>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1071126929.5149.24.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-u9jy+NeNcZ6Ie3wWQrrA";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1071122742.5149.12.camel@idefix.homelinux.org>
 <1288980000.1071126438@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-u9jy+NeNcZ6Ie3wWQrrA
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

> Why would you want to *increase* HZ? I'd say 1000 is already too high
> personally, but I'm curious what you'd want to do with it? Embedded
> real-time stuff?

Actually, my reasons may sound a little strange, but basically I'd be
fine with HZ=3D1000 if it wasn't for that annoying ~1 kHz sound when the
CPU is idle (probably bad capacitors). By increasing HZ to 10 kHz, the
sound is at a frequency where the ear is much less sensitive. Anyway, I
thought some people might be interested in high HZ for other (more
fundamental) reasons, so I posted the patch.

	Jean-Marc
=20
--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-u9jy+NeNcZ6Ie3wWQrrA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/2BmQdXwABdFiRMQRApxIAJ9kRuOx5kVkjZDRkMHpP/R8rsrivwCfRVqA
3YW/o/TOFS/GlzkmeawuGMU=
=FS7G
-----END PGP SIGNATURE-----

--=-u9jy+NeNcZ6Ie3wWQrrA--

