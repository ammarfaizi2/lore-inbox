Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVANV21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVANV21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 16:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVANV0p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 16:26:45 -0500
Received: from zero.voxel.net ([209.123.232.253]:2792 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S262124AbVANV0O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 16:26:14 -0500
Subject: Re: 2.6.10-as1
From: Andres Salomon <dilinger@voxel.net>
To: Daniel Drake <dsd@gentoo.org>
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>, linux-kernel@vger.kernel.org
In-Reply-To: <41E8565A.4050707@gentoo.org>
References: <1105605448.7316.13.camel@localhost>
	 <41E7F44C.5010702@bio.ifi.lmu.de>  <41E8565A.4050707@gentoo.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rIWD2HtMmvOtpTXExe1m"
Date: Fri, 14 Jan 2005 16:26:03 -0500
Message-Id: <1105737963.7677.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rIWD2HtMmvOtpTXExe1m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-01-14 at 23:31 +0000, Daniel Drake wrote:
> Frank Steiner wrote:
> > When I take an unpatched 2.6.10 and apply only the 033 patch, it fails,
> > too. Is it possible that the rlimit patch needs some more patches from
> > the bitkeeper repository to work correctly? And that those patches
> > are missing in the -as1?  Or is the patch just wrong?
> >=20
> > Can anyone confirm this problem? I attach my config for the full -as1
> > tree kernel and a strace log for some segfaulting mount. Hope this help=
s!
>=20
> I can confirm this. For me, fsck exits with sig11 during bootup sequence,=
=20
> which causes my init scripts to think my root partition is dead. Investig=
ating=20
> now...
>=20

Odd.  I'll have to try Frank's .config and see if I can reproduce it (it
doesn't happen w/ mine).


--=20
Andres Salomon <dilinger@voxel.net>

--=-rIWD2HtMmvOtpTXExe1m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB6Djr78o9R9NraMQRAgm+AJ9d436mkKbPy1cWCNg7rchnxf5TQQCfWBUo
TUQ1XqK+49+oh9n4UzfdqYw=
=z714
-----END PGP SIGNATURE-----

--=-rIWD2HtMmvOtpTXExe1m--

