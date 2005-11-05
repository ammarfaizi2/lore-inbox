Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVKEAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVKEAXa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbVKEAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:23:30 -0500
Received: from ctb-mesg6.saix.net ([196.25.240.86]:33997 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S1751363AbVKEAX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:23:29 -0500
Subject: Re: initramfs for /dev/console with udev?
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Rob Landley <rob@landley.net>
Cc: Roland Dreier <rolandd@cisco.com>,
       Robert Schwebel <r.schwebel@pengutronix.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200511041710.36752.rob@landley.net>
References: <20051102222030.GP23316@pengutronix.de>
	 <200511031529.59529.rob@landley.net> <1131140350.9669.7.camel@lycan.lan>
	 <200511041710.36752.rob@landley.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+JONH1aeCQgcImYDBPo4"
Date: Sat, 05 Nov 2005 02:26:34 +0200
Message-Id: <1131150394.9669.11.camel@lycan.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+JONH1aeCQgcImYDBPo4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-11-04 at 17:10 -0600, Rob Landley wrote:
> On Friday 04 November 2005 15:39, Martin Schlemmer wrote:
> > > Ok, I remember why I stopped playing with klibc now.  It's still deep=
 in
> > > alpha-test stage, requires way more incestuous knowledge of the kerne=
l
> > > headers than anything not bundled with the kernel itself has any excu=
se
> > > for, and I'm still not sure what advantage it claims to have over uCl=
ibc
> > > except for being BSD licensed.
> >
> > Well, apparently the plan is to eventually bundle it with the kernel if
> > not mistaken.  Also, it have seen a stable release, and it works well
> > for what it was intended for, and still have a less footprint than
> > uClibc if space is really an issue.
>=20
> *shrug*.  It only does static linking and uClibc can static link too.  Bu=
t=20
> there are no plans to bundle uClibc with the kernel. :)
>=20

It can link dynamic ...

-----
$ readelf -a /usr/lib64/klibc/bin/sh | grep -2 INTERP | tail -n 3
  INTERP         0x0000000000000190 0x0000000000400190 0x0000000000400190
                 0x000000000000002a 0x000000000000002a  R      1
      [Requesting program interpreter: /lib/klibc-zbHWOqxodx0Aind6t75AzMTNE=
9c.so]
-----


--=20
Martin Schlemmer


--=-+JONH1aeCQgcImYDBPo4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDa/w6qburzKaJYLYRAuqzAJ4ismP+EKcG6nbMcTKOpugjmNa+EgCfY1tY
Juh2ePtyEvtBD81R/a9zxsc=
=b4x9
-----END PGP SIGNATURE-----

--=-+JONH1aeCQgcImYDBPo4--

