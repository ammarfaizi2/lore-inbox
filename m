Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbUEJU2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUEJU2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUEJU2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:28:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4588 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261530AbUEJU2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:28:41 -0400
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: gene.heskett@verizon.net
Cc: Rene Herman <rene.herman@keyaccess.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <200405100732.10363.gene.heskett@verizon.net>
References: <409F4944.4090501@keyaccess.nl>
	 <200405100732.10363.gene.heskett@verizon.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Y7SCjCHEFZy8zTBcn3m1"
Organization: Red Hat UK
Message-Id: <1084220917.2996.26.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 May 2004 22:28:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Y7SCjCHEFZy8zTBcn3m1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I note the drive is the same model here too, Rene.
>=20
> The question remains however, is our data in danger?

You have a disk with an active write back cache but that doesn't support
the flush-cache IDE command. That's obviously a bad combo ;)
The other fixes in 2.6.6 ought to make it a bit less dangerous than
before, eg the power off at shutdown WILL flush the cache.


--=-Y7SCjCHEFZy8zTBcn3m1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAn+X1xULwo51rQBIRAhmCAJ95JV+JP++Dmlnr8VNdQ5U6xOQfnwCgkceO
+01jR0D3p+bAzCi/2OE7vmI=
=6xVQ
-----END PGP SIGNATURE-----

--=-Y7SCjCHEFZy8zTBcn3m1--

