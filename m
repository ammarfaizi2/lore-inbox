Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbTLXB1h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263269AbTLXB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:27:37 -0500
Received: from wblv-224-192.telkomadsl.co.za ([165.165.224.192]:2494 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S263260AbTLXB1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:27:33 -0500
Subject: Re: DevFS vs. udev
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Cc: Mark Mielke <mark@mark.mielke.cc>, Ian Kent <raven@themaw.net>,
       release@gentoo.org
In-Reply-To: <20031224010728.GA20956@kroah.com>
References: <E1AYl4w-0007A5-R3@O.Q.NET>
	 <Pine.LNX.4.44.0312240005180.4342-100000@raven.themaw.net>
	 <20031223173429.GA9032@mark.mielke.cc> <20031223220209.GB15946@kroah.com>
	 <1072226715.6917.50.camel@nosferatu.lan> <20031224010728.GA20956@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pFa/hCWujaBTcYDno7wz"
Message-Id: <1072229318.6917.60.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 24 Dec 2003 03:28:38 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pFa/hCWujaBTcYDno7wz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2003-12-24 at 03:07, Greg KH wrote:
> On Wed, Dec 24, 2003 at 02:45:15AM +0200, Martin Schlemmer wrote:
> > Lastly, a small nit with udev currently - how long will it be for in
> > kernel changes to be in place so that we do not need the 1sec delay?
> > It really sucks when you use a script/whatever to populate /dev, and
> > reboot quite frequent for new kernel/rc-script testing :)
>=20
> It's not a kernel change needed, it's a udev/libsysfs change needed.  If
> I didn't have to deal with devfs emails I would get a chance to work on
> the issue some more :)
>=20

Ah, cool - please post if you have something a bit before next udev
release (no pressure), as we might get some extra testing done for you.

> And yes, I have gotten tired of the boot issue too, just add a '&' after
> the udev call in your init scripts and then everything seems to work
> just fine (as far as speed of boot goes.)
>=20

Right, but things needs to be synced for a lot of users, and I'll
rather patch the 1sec out or wait with 010 then get 200 bug reports :)

> But you do have to admit, Gentoo seems to have some pretty rabid users :)
>=20

Same as the other guys (distro's) - they help us keep the rest in
check :)  But I still say its not us that started this *g*


Cheers,

--=20

Martin Schlemmer
Gentoo Linux Developer, Desktop/System Team Developer
Cape Town, South Africa



--=-pFa/hCWujaBTcYDno7wz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/6OvGqburzKaJYLYRAvr/AJ9+5Vc6VEaxRD1xnpxeEvnF8g5HZQCglAJK
jowBvsRKmQHknBD15BSv8ZA=
=H+QG
-----END PGP SIGNATURE-----

--=-pFa/hCWujaBTcYDno7wz--

