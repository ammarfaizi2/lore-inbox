Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264141AbTLEO4e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 09:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbTLEO4e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 09:56:34 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58545 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S264141AbTLEO4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 09:56:32 -0500
Date: Fri, 05 Dec 2003 09:53:47 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: High-pitch noise with 2.6.0-test11
In-reply-to: <3FD05E9C.5080501@thule.no>
To: Troels Walsted Hansen <troels@thule.no>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1070636027.4328.18.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-rNacGTOQnIyeZZd4WQTh";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1070605910.4867.9.camel@idefix.homelinux.org>
 <3FD05E9C.5080501@thule.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rNacGTOQnIyeZZd4WQTh
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Actually, I'm already using ACPI, so it's not an APM problem. I really
don't see what thermal.o can do to cause this.

	Jean-Marc

> I had the same problem with my Dell Latitude C600 and newer kernels with=20
>   HZ>100. The solution I found was to add "apm=3Didle-threshold=3D100" to=
=20
> the kernel commandline, to disable APM idle calls.
>=20
> You should monitor the temperature of your laptop to make sure it=20
> doesn't spin wildly and create extra heat if you use the same solution.
>=20
> Using ACPI instead of APM might also be a solution?
>=20
> Troels
--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-rNacGTOQnIyeZZd4WQTh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/0Jv7dXwABdFiRMQRAos4AJ4xQ8AkZFQ0MouQ2W79OdNjU/nlJgCfdjIt
/mjP0Ot+ZKwQyoyHpZPTij0=
=6IgZ
-----END PGP SIGNATURE-----

--=-rNacGTOQnIyeZZd4WQTh--

