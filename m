Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267271AbUGVUmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267271AbUGVUmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267258AbUGVUmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:42:38 -0400
Received: from wblv-254-37.telkomadsl.co.za ([165.165.254.37]:12981 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S261602AbUGVUle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:41:34 -0400
Subject: Re: audio cd writing causes massive swap and crash
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Jens Axboe <axboe@suse.de>
Cc: Ed Sweetman <safemode@comcast.net>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040722125450.GC3987@suse.de>
References: <40F9854D.2000408@comcast.net> <20040718071830.GA29753@suse.de>
	 <40FBBAAE.5060405@comcast.net> <40FC2E60.2030101@comcast.net>
	 <40FF4563.5070407@comcast.net>  <20040722125450.GC3987@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-8noBJjGbctyGW6gtzq8P"
Message-Id: <1090529059.10205.34.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 22 Jul 2004 22:44:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-8noBJjGbctyGW6gtzq8P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-07-22 at 14:54, Jens Axboe wrote:
> On Thu, Jul 22 2004, Ed Sweetman wrote:
> > I've had other people test writing.  It appears that scsi-emu is not=20
> > effected by this memory leak when writing audio cds.  So it would appea=
r=20
> > that ide-cd along with any of the dependent ide source files is the=20
> > culprit. But I cannot find anywhere in ide-cd that is apparent to being=
=20
> > a mem leak.  There are various conditions in ide_do_drive_cmd that stat=
e=20
> > that the cdrom driver has to be very careful about handling but without=
=20
> > intimate knowledge of the driver, I can't be sure that it's sufficientl=
y=20
> > handling those situations. =20
> >=20
> > Surprisingly, it's very hard to find anyone who's used the native atapi=
=20
> > mode to write an audio cd in 2.6.  Which is partly why this problem=20
> > hasn't generated more mail traffic here I would guess.=20
>=20
> That's not true, lots of people use it. But, oddly, the leak isn't
> reproducable on any machine I've tested.

I seem to remember he noted a patch about dma during audio writing,
and his 'testing' if it might be the cause was to just disable dma
on the drive ...

--=20
Martin Schlemmer

--=-8noBJjGbctyGW6gtzq8P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBACcjqburzKaJYLYRAoRuAKCKVvG1Z704Sk+AnJzhbNf9a4M6kwCfb4/+
IduLpK6EO6hlezwHxwqGuxQ=
=+9kd
-----END PGP SIGNATURE-----

--=-8noBJjGbctyGW6gtzq8P--

