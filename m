Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTLYTjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 14:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbTLYTjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 14:39:12 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:35806 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S262353AbTLYTjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 14:39:09 -0500
Subject: Re: [PATCH] add sysfs mem device support  [2/4]
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Andreas Jellinghaus <aj@dungeon.inka.de>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20031225184553.A25397@infradead.org>
References: <20031223002126.GA4805@kroah.com>
	 <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com>
	 <20031223131523.B6864@infradead.org> <1072193516.3472.3.camel@fur>
	 <20031223163904.A8589@infradead.org>
	 <pan.2003.12.25.17.47.43.603779@dungeon.inka.de>
	 <20031225184553.A25397@infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OSVDzoNNY8IzRoNKdEYz"
Message-Id: <1072381287.7638.52.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 25 Dec 2003 21:41:28 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OSVDzoNNY8IzRoNKdEYz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-12-25 at 20:45, Christoph Hellwig wrote:
> On Thu, Dec 25, 2003 at 06:48:51PM +0100, Andreas Jellinghaus wrote:
> > On Tue, 23 Dec 2003 16:47:44 +0000, Christoph Hellwig wrote:
> > > I disagree. For fully static devices like the mem devices the udev
> > > indirection is completely superflous.
> >=20
> > If sysfs does not contain data on mem devices, we will need makedev.
> >=20
> > devfs did replace makedev. until udev can create all devices,
> > it would need to re-introduce makedev.
>=20
> So what?
>=20

So maybe suggest an solution rather than shooting one down all the
time (which do seem logical, and is only apposed by one person currently
- namely you =3D).

I currently run a system with Greg's patches + udev, and all the devices
are generated via udev and a modified version of Robert's initscript
(running much earlier), with only alsa's nodes generated via another
script as it is not sysfs-ified yet.  So basically the initramfs idea
is fully plausible if initramfs will get there (or I get time to have
a look).=20


--=20
Martin Schlemmer

--=-OSVDzoNNY8IzRoNKdEYz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6z1nqburzKaJYLYRAvLKAJ9QHk7i24Ma0BQz/spZ6KdCvY28CwCfXuWh
hqyxZJjHkJYeLaUnrlXkmI4=
=tum/
-----END PGP SIGNATURE-----

--=-OSVDzoNNY8IzRoNKdEYz--

