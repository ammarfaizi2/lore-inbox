Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUHAIxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUHAIxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 04:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUHAIxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 04:53:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23967 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265510AbUHAIxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 04:53:11 -0400
Subject: Re: How to do IO across hardsector boundries
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: "Thomas S. Iversen" <zensonic@zensonic.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <410C37B7.3010504@zensonic.dk>
References: <410C37B7.3010504@zensonic.dk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-B5DQRgdHfNyYwoCep3Cu"
Organization: Red Hat UK
Message-Id: <1091350388.2816.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 01 Aug 2004 10:53:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-B5DQRgdHfNyYwoCep3Cu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-08-01 at 02:22, Thomas S. Iversen wrote:
> Hi There
>=20
> As part of an assignment I am trying to port a piece of software from=20
> FreeBSD to linux. Essentially this software (crypto) makes a virtual=20
> blockdevice with "virtual" sectors on top. Under FreeBSD these virtual=20
> sectors are just read/written using a simple command:

I can recommend that you look at the Device Mapper layer and consider
porting your code to that, it's designed to take care of some of the
hard work for you for usages like this.

--=-B5DQRgdHfNyYwoCep3Cu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBDK9zxULwo51rQBIRAhlJAJ4mNzIxm5JWp7zB311hqb749bWMEwCfQGo1
0UMNBw6neClH4niDFMTbGko=
=RcNC
-----END PGP SIGNATURE-----

--=-B5DQRgdHfNyYwoCep3Cu--

