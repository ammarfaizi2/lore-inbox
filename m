Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266100AbUBCUrA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 15:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266129AbUBCUrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 15:47:00 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:21640 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266100AbUBCUq6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 15:46:58 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203193351.GY21151@parcelfarce.linux.theplanet.co.uk>
References: <20040203010224.4CF742C261@lists.samba.org>
	 <1075830486.7473.32.camel@nosferatu.lan>
	 <20040203193351.GY21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-wTwa3b/5nZp1mLbVbQi0"
Message-Id: <1075841233.7473.54.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 22:47:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-wTwa3b/5nZp1mLbVbQi0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 21:33, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Tue, Feb 03, 2004 at 07:48:06PM +0200, Martin Schlemmer wrote:
> > > > I guess there will be cries of murder if 'somebody' suggested that =
if
> > > > a node in /dev is opened, but not there, the kernel can call
> > > > 'modprobe -q /dev/foo' to load whatever alias there might have been=
?
>=20
> Vetoed.  _Especially_ when you are checking that on "pathname prefix"
> level - namei.c is not a place for such special-casing.
>=20

Well, I do not scratch around in there in general.  I guess the question
is:

1)  This this idea is Ok to make it (not patch or where it is, but the
idea in general.

2)  If yes to 1), any suggested place I should have a look at?


Thanks,

--=20
Martin Schlemmer

--=-wTwa3b/5nZp1mLbVbQi0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIAjRqburzKaJYLYRAk0XAJ9vhTmdun7SPwBaBQp/qoght1DhVACglONM
2AclocufwuukHSnvH4OuA1A=
=fLk5
-----END PGP SIGNATURE-----

--=-wTwa3b/5nZp1mLbVbQi0--

