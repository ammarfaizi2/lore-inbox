Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbUAAWBW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:01:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUAAWAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:00:35 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:12679 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S265415AbUAAVuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 16:50:44 -0500
Subject: Re: udev and devfs - The final word
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <3FF47AAA.7090903@myrealbox.com>
References: <fa.flhsork.uka2hg@ifi.uio.no> <fa.hv9hpq7.1l1q9p3@ifi.uio.no>
	 <3FF47AAA.7090903@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-tB9syTRZ0mZ4UbSqIxi/"
Message-Id: <1072993997.14629.40.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 23:53:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tB9syTRZ0mZ4UbSqIxi/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-01-01 at 21:53, walt wrote:
> Martin Schlemmer wrote:
> > On Thu, 2004-01-01 at 00:17, walt wrote:
>=20
> >> ...I have  not been able to get udev working yet...
>=20
> > Hmm, It works fine here?  I was under the impression that
>  > it should _just_work_ if you have latest everything unstable...
>=20
> Yes!  I want to confirm that it DOES 'just work' with this one
> little thingy I missed:
>=20
> I needed to add TWO boot flags because of the way I have my
> kernel configured:  'nodevfs' AND 'devfs=3Dnomount'.
>=20
> Without the 'devfs=3Dnomount' flag the kernel was starting devfsd
> anyway, which keeps udev from working, apparently.
>=20

Hmm, right, that will do it.

Perhaps I could change this to display a warning if udev is present,
but devfs is mounted over /dev ...


--=20
Martin Schlemmer

--=-tB9syTRZ0mZ4UbSqIxi/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQA/9JbNqburzKaJYLYRAuj/AJ9yv27EP5ahJD6OgzkD+wPu/lzuygCgke+d
5gjPCeoYsIWgvXsg9H/BIiY=
=OA4y
-----END PGP SIGNATURE-----

--=-tB9syTRZ0mZ4UbSqIxi/--

