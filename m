Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbUC2MA2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbUC2MA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:00:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:62926 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262827AbUC2MAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:00:21 -0500
Subject: Re: failure to mount root fs
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: tigran@aivazian.fsnet.co.uk
Cc: Marco Baan <marco@freebsd.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <26889266.1080559781017.JavaMail.www@wwinf3002>
References: <26889266.1080559781017.JavaMail.www@wwinf3002>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qhwKyzboxnm0BVOLXLCH"
Organization: Red Hat, Inc.
Message-Id: <1080561608.3570.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 14:00:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-qhwKyzboxnm0BVOLXLCH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-03-29 at 13:29, tigran@aivazian.fsnet.co.uk wrote:
> Hi Macro,
>=20
> You wrote:
>=20
> > VFS: Unable to mount root fs on unknown-block(0,0)
> > ...
> > kernel /boot/bzImage-2.6.4 ro root=3DLABEL=3D/
>=20
> The "LABEL=3D/" is the attempt to mount root filesystem by label, so you =
can=20
> move it to another disk. I find these "clever" things not mature yet and =
always replace it by an explicit device name (and don't move/replace root d=
isk):

it's ok as long as you remember to make an initrd (make install in the
kernel source will do so automatic, at least on a RH/Fedora system)

--=-qhwKyzboxnm0BVOLXLCH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAaA/HxULwo51rQBIRAncXAJ0VxDhGo9oXUT/wWH57VnIPTwjQqwCfdsoI
LqKZgODvPOnxjrNH7iFaQvc=
=G3t5
-----END PGP SIGNATURE-----

--=-qhwKyzboxnm0BVOLXLCH--

