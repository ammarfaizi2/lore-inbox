Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270007AbTGLKGJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 06:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270008AbTGLKGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 06:06:08 -0400
Received: from mx.laposte.net ([213.30.181.11]:26786 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S270007AbTGLKGG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 06:06:06 -0400
Subject: Re: MCE exception advice
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1058004581.6808.10.camel@rousalka.dyndns.org>
References: <1058004581.6808.10.camel@rousalka.dyndns.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WNMQvqaghERO6cDfFG1t"
Organization: Adresse personnelle
Message-Id: <1058005248.7107.1.camel@rousalka.dyndns.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jul 2003 12:20:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WNMQvqaghERO6cDfFG1t
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le sam 12/07/2003 =E0 12:09, Nicolas Mailhot a =E9crit :
> [ Please CC me on answers since I'm not on the list ]
>=20
> Hi,
>=20
> 	I've been getting MCE's repeatedly today when trying to compile
> 2.5.75-bk1 on 2.5.75-bk1 (obviously I didn't have them yesterday when I
> build my first 2.5.75-bk1 kernel on a 2.4 kernel).
>=20
> 	The MCE is always the same (I think) and reads like this :
>=20
> CPU 0: Machine Check Exception: 0000000000000004
> Bank 0: b600000000000135 at 000000000b99b9f0

Well looking in the logs the MCE type is always the same but the actual
address changes :

/var/log/messages:4371:Jul 12 11:14:08 rousalka kernel: Bank 0:
b67e800000000135 at 0000000004fc8678
/var/log/messages:4692:Jul 12 11:22:52 rousalka kernel: Bank 0:
b607000000000135 at 0000000011b6e7f0
/var/log/messages:4982:Jul 12 11:29:49 rousalka kernel: Bank 0:
b674000000000135 at 0000000017c029f0
/var/log/messages:5265:Jul 12 11:45:15 rousalka kernel: Bank 0:
b600000000000135 at 000000000b99b9f0

What's the best course of action now ?

--=20
Nicolas Mailhot

--=-WNMQvqaghERO6cDfFG1t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/D+EAI2bVKDsp8g0RApYGAKCQmZDYNXLGl0isehQDeRvaDO/DNgCgtfWF
0ClGFB+4ewHq9SWiGQCnx1U=
=tDyS
-----END PGP SIGNATURE-----

--=-WNMQvqaghERO6cDfFG1t--

