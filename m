Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWGDLVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWGDLVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 07:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWGDLVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 07:21:06 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:5816 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751285AbWGDLVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 07:21:04 -0400
Date: Tue, 04 Jul 2006 07:20:43 -0400
From: David Hollis <dhollis@davehollis.com>
Subject: Re: D-Link DUB-E100 Revision B1
In-reply-to: <200607040333.13649.bero@arklinux.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, pchang23@sbcglobal.net
Message-id: <1152012043.2494.13.camel@dhollis-lnx.sunera.com>
MIME-version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5)
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="=-pyTduybdjEBnVW8Z3x2w"
References: <200607040333.13649.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pyTduybdjEBnVW8Z3x2w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-07-04 at 03:33 +0200, Bernhard Rosenkraenzer wrote:
> Looks like D-Link is getting into the funny "change the chipset but leave=
 the=20
> product name the same" game again.
>=20
> DUB-E100 cards up to Revision A4 work perfectly, Revision B1 doesn't work=
 at=20
> all.
>=20
> The patch I've attached has the beginnings of a fix; unfortunately this=20
> trivialty doesn't fix it fully -- with the patch, the module loads, the M=
AC=20
> address is detected correctly, the LEDs go on, but pings don't get throug=
h=20
> yet.
>=20

> Chances are it needs some more messing with the .data and/or .flags=20
> parameters.

That's my guess as well.  It probably has a different GPIO configuration
than the other AX88772 devices.  Unfortunately, I haven't been able to
find out what that configuration is.  A USB trace of the Windows driver
initializing the device would be extremely helpful to determine what is
necessary.  I've tried to contact DLink, but it seems to get in depth
technical info like that may take a lot of work.
 =20
--=20
David Hollis <dhollis@davehollis.com>

--=-pyTduybdjEBnVW8Z3x2w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqk8KxasLqOyGHncRAtB9AJ4ihLu3JXRS1kdMg1a35P79wXf8ZgCgqTto
rk9hzPn1BnAfuiEPlkMwhpA=
=FV18
-----END PGP SIGNATURE-----

--=-pyTduybdjEBnVW8Z3x2w--

