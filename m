Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbTKFUIh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTKFUIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:08:37 -0500
Received: from wblv-224-88.telkomadsl.co.za ([165.165.224.88]:57227 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S263795AbTKFUId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:08:33 -0500
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: "David S. Miller" <davem@redhat.com>
Cc: KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20031106113716.7382e5d2.davem@redhat.com>
References: <1068140199.12287.246.camel@nosferatu.lan>
	 <20031106093746.5cc8066e.davem@redhat.com>
	 <1068143563.12287.264.camel@nosferatu.lan>
	 <1068144179.12287.283.camel@nosferatu.lan>
	 <20031106113716.7382e5d2.davem@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Pl67RzEdYYTB4MyCVGbH"
Message-Id: <1068149368.12287.331.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 06 Nov 2003 22:09:29 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Pl67RzEdYYTB4MyCVGbH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-11-06 at 21:37, David S. Miller wrote:
> On Thu, 06 Nov 2003 20:42:59 +0200
> Martin Schlemmer <azarah@gentoo.org> wrote:
>=20
> > Ok, so maybe above is not a case to work on, but if I write an
> > app that use only 32bit data types, and it links to a library that
> > also handles 64bit, it does not matter, as I do not call the functions
> > that handle 64bit data types, no ?
>=20
> Let's say that you end up using some inline function
> that takes u32 arguments, and internally it uses
> u64 types to speed up the calculation or make it more
> accurate or something like that.

So basically only in cases where the stuff in byteorder.h
was not inlined ... ?


Thanks,

--=20

Martin Schlemmer




--=-Pl67RzEdYYTB4MyCVGbH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qqp4qburzKaJYLYRAiRwAJ9lUpKE+YLVXV/JVPcke5bJrPYcPgCeIy6B
nmFpEHjDgKVmZBwCmDpNKVU=
=vIyc
-----END PGP SIGNATURE-----

--=-Pl67RzEdYYTB4MyCVGbH--

