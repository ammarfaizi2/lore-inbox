Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTLCBap (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 20:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTLCBap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 20:30:45 -0500
Received: from c-130372d5.012-136-6c756e2.cust.bredbandsbolaget.se ([213.114.3.19]:35971
	"EHLO pomac.netswarm.net") by vger.kernel.org with ESMTP
	id S264480AbTLCBan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 20:30:43 -0500
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
From: Ian Kumlien <pomac@vapor.com>
To: b@netzentry.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FCD3B0F.6060700@netzentry.com>
References: <3FCD3B0F.6060700@netzentry.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+LIyxTkmKjT7S5Ts/qjy"
Message-Id: <1070415038.1759.30.camel@big.pomac.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 03 Dec 2003 02:30:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+LIyxTkmKjT7S5Ts/qjy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-03 at 02:23, b@netzentry.com wrote:
> How is the performance of the generic IDE driver?
>=20
> My experience that it was almost unusable (kernel 2.4.22,
> 2.4.23) (fsck taking hours, etc)

Thats not the issue... The issue is if the machine survives or crashes.
Again, it locks up for quite some time but it always comes back. And you
get a "hda lost interrupt" message in dmesg.

If we all have that, and deadlock when using the amd/nvidia driver..
then we know that that might be the fault. The machine still locks for a
while so, it's not just the ide, but it might be a good place to start.

--=20
Ian Kumlien <pomac@vapor.com>

--=-+LIyxTkmKjT7S5Ts/qjy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zTy+7F3Euyc51N8RApFPAJoDLvx9lWsiX7Dw67AXQ0Cz7ivKfACePjfZ
U3avQIxcCgLnjnjzBw0wJ/c=
=LPQY
-----END PGP SIGNATURE-----

--=-+LIyxTkmKjT7S5Ts/qjy--

