Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUBCVea (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 16:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUBCVea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 16:34:30 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:25992 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266009AbUBCVeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 16:34:14 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203205330.GZ21151@parcelfarce.linux.theplanet.co.uk>
References: <20040203010224.4CF742C261@lists.samba.org>
	 <1075830486.7473.32.camel@nosferatu.lan>
	 <20040203193351.GY21151@parcelfarce.linux.theplanet.co.uk>
	 <1075841233.7473.54.camel@nosferatu.lan>
	 <20040203205330.GZ21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Uob4fkYnx+MRS8qotqLt"
Message-Id: <1075844070.7473.64.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 23:34:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Uob4fkYnx+MRS8qotqLt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 22:53, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Tue, Feb 03, 2004 at 10:47:13PM +0200, Martin Schlemmer wrote:
> > On Tue, 2004-02-03 at 21:33, viro@parcelfarce.linux.theplanet.co.uk
> > wrote:
> > > On Tue, Feb 03, 2004 at 07:48:06PM +0200, Martin Schlemmer wrote:
> > > > > > I guess there will be cries of murder if 'somebody' suggested t=
hat if
> > > > > > a node in /dev is opened, but not there, the kernel can call
> > > > > > 'modprobe -q /dev/foo' to load whatever alias there might have =
been?
> > >=20
> > > Vetoed.  _Especially_ when you are checking that on "pathname prefix"
> > > level - namei.c is not a place for such special-casing.
> > >=20
> >=20
> > Well, I do not scratch around in there in general.  I guess the questio=
n
> > is:
> >=20
> > 1)  This this idea is Ok to make it (not patch or where it is, but the
> > idea in general.
>=20
> It is not.  Consider the effect of cd /dev followed by lookups.  Do you
> really want a different behaviour in that case?  Ditto for use of
> symlinks, yadda, yadda.

Any other ideas for the problem in general? =3D)


Thanks,

--=20
Martin Schlemmer

--=-Uob4fkYnx+MRS8qotqLt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAIBPmqburzKaJYLYRAvIXAJ9SQmC+VYmYxllfJIwGQQrkpjAetACfaFdx
SOqfPxSdocu+nWq2nxx0eOQ=
=w8ya
-----END PGP SIGNATURE-----

--=-Uob4fkYnx+MRS8qotqLt--

