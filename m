Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTFPLe1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 07:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTFPLe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 07:34:27 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:52976 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S263765AbTFPLe0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 07:34:26 -0400
Subject: Re: 2.4.21 oops
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Andrzej Sosnowski <raptor@lists.raptor.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306161220200.19177-100000@athena.raptor.pl>
References: <Pine.LNX.4.44.0306161220200.19177-100000@athena.raptor.pl>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Crjr0bVyewqBwS3A9ogY"
Organization: Red Hat, Inc.
Message-Id: <1055764075.2113.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 16 Jun 2003 13:47:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Crjr0bVyewqBwS3A9ogY
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-06-16 at 13:40, Andrzej Sosnowski wrote:
> Hi.
>=20
> Kernel makes an oops while executing the following script:
>=20
> #!/bin/sh
> for IP in `/usr/bin/seq 3 500`; do
>   ip addr add 3ffe:80ee:c1d::$IP/48 dev eth0
>   ip addr add 3ffe:80ee:c1d::a:$IP/48 dev eth0
> done
>=20
> Result:
> kernel BUG sched.c 564!
> (sorry for incomplete oops message)
>=20
> Tested on:
>   debian 2.4.21
>   debian/redhat 2.4.21-grsec 1.9.10
>   redhat 2.4.21-uv2-grsec 1.9.10

please try this without the grsecurity patch


--=-Crjr0bVyewqBwS3A9ogY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+7a5qxULwo51rQBIRAr/wAJ4l4/V/pQpHLGnQ5YifKB2lfjJ4dACghclY
CW2YLok77FLV0l+yiWbNEpg=
=8xCT
-----END PGP SIGNATURE-----

--=-Crjr0bVyewqBwS3A9ogY--
