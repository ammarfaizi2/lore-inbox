Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbUCVQBr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbUCVQBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:01:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32641 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262070AbUCVQBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:01:45 -0500
Subject: Re: [PATCH] ISDN Eicon driver: restructured capi list and lock
	handling
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: armin@melware.de
In-Reply-To: <200403211807.i2LI7e2O004808@hera.kernel.org>
References: <200403211807.i2LI7e2O004808@hera.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ERGgt4mm7B86GFKpjskx"
Organization: Red Hat, Inc.
Message-Id: <1079971289.5296.10.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 22 Mar 2004 17:01:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ERGgt4mm7B86GFKpjskx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-03-21 at 17:55, Linux Kernel Mailing List wrote:
> ChangeSet 1.1828, 2004/03/21 08:55:24-08:00, armin@melware.de
>=20
> 	[PATCH] ISDN Eicon driver: restructured capi list and lock handling
> =09
> 	Restructered the CAPI code of list handling and lock.
> =09
> 	Removed obsolete code.

this patch is broken:
Error: ./drivers/isdn/hardware/eicon/capifunc.o .altinstructions refers
to 00000018 R_386_32          .exit.text
Error: ./drivers/isdn/hardware/eicon/capifunc.o .init.text refers to
0000015d R_386_PC32        .exit.text

eg you call __exit functions from __init functions, which is
incorrect....

--=-ERGgt4mm7B86GFKpjskx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAXw3YxULwo51rQBIRAsEsAKCD4OuxlCtcm5G8mqzy4lpCHfW9tACggviT
sJ7hW+jAPqvfReBT1HIpD4U=
=jM+R
-----END PGP SIGNATURE-----

--=-ERGgt4mm7B86GFKpjskx--

