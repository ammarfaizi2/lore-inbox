Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbWLAUx0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbWLAUx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 15:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936565AbWLAUx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 15:53:26 -0500
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:27363 "EHLO
	slurp.thebarn.com") by vger.kernel.org with ESMTP id S936564AbWLAUxZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 15:53:25 -0500
Subject: Re: [Cluster-devel] Re: [GFS2] Change argument of gfs2_dinode_out
	[17/70]
From: Russell Cattelan <cattelan@thebarn.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: cluster-devel@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20061201192555.GD3078@ftp.linux.org.uk>
References: <1164888933.3752.338.camel@quoit.chygwyn.com>
	 <1165000744.1194.89.camel@xenon.msp.redhat.com>
	 <20061201192555.GD3078@ftp.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-DofeCuqA18tYDCHBG+rV"
Date: Fri, 01 Dec 2006 14:52:11 -0600
Message-Id: <1165006331.1194.96.camel@xenon.msp.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1-1mdv2007.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-DofeCuqA18tYDCHBG+rV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-12-01 at 19:25 +0000, Al Viro wrote:
> On Fri, Dec 01, 2006 at 01:19:04PM -0600, Russell Cattelan wrote:
> > On Thu, 2006-11-30 at 12:15 +0000, Steven Whitehouse wrote:
> > > >From 539e5d6b7ae8612c0393fe940d2da5b591318d3d Mon Sep 17 00:00:00 20=
01
> > > From: Steven Whitehouse <swhiteho@redhat.com>
> > > Date: Tue, 31 Oct 2006 15:07:05 -0500
> > > Subject: [PATCH] [GFS2] Change argument of gfs2_dinode_out
> > >=20
> > > Everywhere this was called, a struct gfs2_inode was available,
> > > but despite that, it was always called with a struct gfs2_dinode
> > > as an argument. By making this change it paves the way to start
> > > eliminating fields duplicated between the kernel's struct inode
> > > and the struct gfs2_dinode.
> > More pointless code churn.
> >=20
> > This only makes sense once the file system is working=20
> > and we have time to do this type of cleanup on against
> > a stable and TESTED code base.
>=20
> Bzzert.  Cleaner code is easier to _get_ stable.  "Keep it ucking fugly
> until everyone stops looking at it out of sheer disgust" is a bad idea.'
code clean up are not without risk and with no regression test suite to
verify
that a "cleanup" has not broken something. Cleanups are very much a
hindrance to stabilization. With no know working points in a code
history it becomes difficult
to bisect changes and figure out when bugs were introduced
Especially when cleanups are mixed in with bug fixes.

Pretty code does not equal correct code.


--=20
Russell Cattelan <cattelan@thebarn.com>

--=-DofeCuqA18tYDCHBG+rV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcJX7NRmM+OaGhBgRAhftAJ9ABVSVyYoASnof9jJWe79OVVzs8QCfSnwV
j1KikKWxCu62DFYOizok8Nw=
=QfNV
-----END PGP SIGNATURE-----

--=-DofeCuqA18tYDCHBG+rV--

