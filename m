Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUC2VWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbUC2VWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:22:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32724 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262538AbUC2VW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:22:29 -0500
Subject: Re: older kernels + new glibc?
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Lev Lvovsky <lists1@sonous.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com>
	 <1080594005.3570.12.camel@laptop.fenrus.com>
	 <50DC82B4-81C5-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a+jGT7/UN1HymctbgSXd"
Organization: Red Hat, Inc.
Message-Id: <1080595343.3570.15.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 23:22:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-a+jGT7/UN1HymctbgSXd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-29 at 23:09, Lev Lvovsky wrote:
> We have the source of the drivers, but they are specific to the 2.2.x=20
> kernels.  I am not a kernel hacker, and this would be way beyond my=20
> area of expertise.
>=20
> And sadly, this doesn't answer the initial question.

then to answer your question; at compile time you tell glibc what
minimum kernel version it can assume, and based on that glibc will
enable/disable certain features. So it depends on what your distro
supplied there if it'll work or not. if you tell glibc that at minimum
you do 2.4.1 for example, then no a 2.2 kernel won't work. I think most
distros do this (or an even later version) since a few years now.

--=-a+jGT7/UN1HymctbgSXd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaJOPxULwo51rQBIRAnqaAKCd9B343/FBEdHpPsvXE7Vy3zkJLgCfRUPE
xkjsv8+pgtJUgsdGJlTLyNk=
=x4U2
-----END PGP SIGNATURE-----

--=-a+jGT7/UN1HymctbgSXd--

