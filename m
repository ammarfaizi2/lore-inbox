Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbUB0RyT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 12:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263080AbUB0RyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 12:54:19 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:29105 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263079AbUB0RyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 12:54:16 -0500
Subject: Re: Network error with Intel E1000 Adapter on update 2.4.25 ==>
	2.6.3
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Martin Bene <martin.bene@icomedias.com>
In-Reply-To: <200402271338.01853@WOLK>
References: <FA095C015271B64E99B197937712FD020B01BB@freedom.grz.icomedias.com>
	 <200402271338.01853@WOLK>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZPf3KOtQ7mtwZ7NCcWIl"
Message-Id: <1077904451.14545.3.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 18:54:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZPf3KOtQ7mtwZ7NCcWIl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-02-27 at 13:38, Marc-Christian Petersen wrote:
> On Friday 27 February 2004 13:22, Martin Bene wrote:
>=20
> Hi Martin,
>=20
> > When trying to update the kernel from 2.4.25 to 2.6.3 I run into a prob=
elm:
> > While the driver for the onboard Intel E1000 network adapter loads OK, =
it
> > doesn't seem to find an interrupt for the interface - ifconfig shows:
> > eth0      Link encap:Ethernet  HWaddr 00:0E:A6:2D:7A:64
> >           BROADCAST MULTICAST  MTU:1500  Metric:1
> >           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
> >           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
> >           collisions:0 txqueuelen:1000
> >           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
> >           Base address:0x9000 Memory:fc000000-fc020000
> > [ ... ripped the rest ... ]
> > Board is an Asus PC-DL, Intel 875P Chipset, one Xeon 2.8Ghz CPU, Onboar=
d
> > e1000 Network interface. Any idea how I can get the onboard NIC to work=
?
>=20
> full output of /var/log/dmesg || dmesg after bootup might help.

e1000 is known to have problems in 2.6.3

Please try the latest 2.6.3-bk snapshot, it may work better, it has
helped at least one other reporter of e1000 problems in 2.6.3

--=20
/Martin

--=-ZPf3KOtQ7mtwZ7NCcWIl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAP4RDWm2vlfa207ERAheYAJ4yt0zacPZ8LCFiczi2lbUaKYus9wCgvUYT
KzuV/s2gh14cnypXvOzzdBY=
=GWbp
-----END PGP SIGNATURE-----

--=-ZPf3KOtQ7mtwZ7NCcWIl--
