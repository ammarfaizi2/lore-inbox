Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267737AbUHWVw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267737AbUHWVw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268146AbUHWVjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:39:36 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:58305 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S267891AbUHWVYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:24:21 -0400
Subject: Re: [PATCH][7/7] add xattr support to ramfs [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Greg KH <greg@kroah.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040823205942.GA3370@kroah.com>
References: <Xine.LNX.4.44.0408231420100.13728-100000@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0408231421200.13728-100000@thoron.boston.redhat.com>
	 <20040823212623.A20995@infradead.org>
	 <1093292789.27211.279.camel@moss-spartans.epoch.ncsc.mil>
	 <20040823205942.GA3370@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G7f2nFOglPHToUCijAgB"
Message-Id: <1093296463.7561.0.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 23:27:44 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-G7f2nFOglPHToUCijAgB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-08-23 at 22:59, Greg KH wrote:
> On Mon, Aug 23, 2004 at 04:26:29PM -0400, Stephen Smalley wrote:
> > On Mon, 2004-08-23 at 16:26, Christoph Hellwig wrote:
> > > On Mon, Aug 23, 2004 at 02:22:20PM -0400, James Morris wrote:
> > > > This patch adds xattr support to tmpfs, and a security xattr handle=
r.
> > > > Original patch from: Chris PeBenito <pebenito@gentoo.org>
> > >=20
> > > What's the point on doing this for ramfs?  And if you really want thi=
s
> > > the implementation could be shared with tmpfs easily and put into xat=
tr.c
> >=20
> > For udev.
>=20
> What's wrong with using a tmpfs for udev in such situations that xattrs
> are needed?  udev does not require ramfs at all.  In fact, why not just
> use a ext2 or ext3 partition for /dev instead today, if you really need
> it?
>=20

Root-less boxes comes to mind ...  Wont comment on if tmpfs/ramfs
should be used though - that you guys can sort out =3D)


Thanks,

--=20
Martin Schlemmer

--=-G7f2nFOglPHToUCijAgB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBKmFPqburzKaJYLYRAtDkAJ9coqAXyzQVQMc5DoqLM5oAHlYQ7QCfasMC
vLeV9BhJ/AFrqj2KYqcQqaI=
=BGw5
-----END PGP SIGNATURE-----

--=-G7f2nFOglPHToUCijAgB--

