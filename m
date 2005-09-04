Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751091AbVIDVFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbVIDVFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbVIDVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:05:07 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:28043 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S1751091AbVIDVFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:05:06 -0400
Date: Sun, 4 Sep 2005 14:04:46 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jan De Luyck <lkml@kcore.org>,
       USB Storage list <usb-storage@lists.one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Genesys USB 2.0 enclosures
Message-ID: <20050904210446.GA16290@one-eyed-alien.net>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Jan De Luyck <lkml@kcore.org>,
	USB Storage list <usb-storage@lists.one-eyed-alien.net>,
	USB development list <linux-usb-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <200509031812.54753.lkml@kcore.org> <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0509032151040.5675-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 03, 2005 at 09:53:19PM -0400, Alan Stern wrote:
> On Sat, 3 Sep 2005, Jan De Luyck wrote:
>=20
> > I've posted in the past about problems with these enclosures - increasi=
ng the=20
> > delay seems to fix it, albeit temporarily. The further you go in using =
the=20
> > disk in such an enclosure, the higher the udelay() had to be - atleast =
that's=20
> > what I'm seeing here (I've got two of these now :/ )
> >=20
> > One permanent fix is adding a powered USB-hub in between the drive encl=
osures=20
> > and the computer. Since I've done that, I've no longer seen any of the=
=20
> > problems (i've attached the 'fault' log). Weird but true, since the dri=
ves=20
> > come with their own powersupply.
> >=20
> > Hope this helps anyone in the future running into the same problem.
>=20
> This one certainly goes into the Bizarro file.
>=20
> Just out of curiosity -- when you use the powered hub, does the drive wor=
k=20
> even if you remove that delay completely?

Aren't USB 2.0 hubs more "intelligent" as part of the requirement to
support 1.1 and 2.0 devices?  I wonder if it's really a 2.0 drive, and if
the timing is different enough with the hub to make a difference.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

THEY CASTRATED MY QUAKE BITS! I WANT THEM BACK!!!!
					-- Greg
User Friendly, 3/27/1998

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDG2FuHL9iwnUZqnkRArAhAJ98RKmiNJBrlXOP6nb4Dz2I0//TjwCfUbKc
1nQhjJQCeosn1BqejJR9KW4=
=BSrx
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
