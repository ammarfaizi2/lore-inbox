Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbTLIGuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 01:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTLIGuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 01:50:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32956 "EHLO
	VL-MO-MR005.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S263221AbTLIGuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 01:50:51 -0500
Date: Tue, 09 Dec 2003 01:46:51 -0500
From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Re: High-pitch noise with 2.6.0-test11
In-reply-to: <20031207172653.GA379@elf.ucw.cz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Message-id: <1070952411.6754.14.camel@idefix.homelinux.org>
Organization: =?ISO-8859-1?Q?Universit=C3=A9_de?= Sherbrooke
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7)
Content-type: multipart/signed; boundary="=-V0uMBIYWy+ttsr4DI60j";
 protocol="application/pgp-signature"; micalg=pgp-sha1
References: <1070605910.4867.9.camel@idefix.homelinux.org>
 <20031207172653.GA379@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-V0uMBIYWy+ttsr4DI60j
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> I'm afraid this is common prolem; most notebooks I sen do some kind of
> annoying noise under some circumstances. Therewas technical discussion
> about why that happens on ACPI list.

It seems like the noise frequency is directly related to the value of HZ
and HZ=3D1000 is especially annoying as the ear is very sensitive. I was
wondering how hard it would be to allow values of HZ in the range of
10-20 kHz? I have attempted to do so, but it seems like part of the code
is not ready for that. Even after setting the right SHIFT_HZ in timex.h,
setting HZ=3D10000 causes things like division by zero and negative
shifts. Is there a way to do it anyway?

        Jean-Marc

--=20
Jean-Marc Valin, M.Sc.A., ing. jr.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada

--=-V0uMBIYWy+ttsr4DI60j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e=2E?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/1W/bdXwABdFiRMQRAiUKAJ94uQjyWCIyXOVAjrfVd9DLj6zEAQCggmxu
K0LfR00TGIGjwP6Du02MWYQ=
=BpJA
-----END PGP SIGNATURE-----

--=-V0uMBIYWy+ttsr4DI60j--

