Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130638AbQLNJ3R>; Thu, 14 Dec 2000 04:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131575AbQLNJ3H>; Thu, 14 Dec 2000 04:29:07 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:7433 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S130638AbQLNJ26>; Thu, 14 Dec 2000 04:28:58 -0500
Date: Thu, 14 Dec 2000 00:58:26 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Brian Litzinger <brian@top.worldcontrol.com>, linux-kernel@vger.kernel.org
Subject: Re: Is this a compromise and how?
Message-ID: <20001214005826.H12544@one-eyed-alien.net>
Mail-Followup-To: Brian Litzinger <brian@top.worldcontrol.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20001214005345.A3732@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ewQ5hdP4CtoTt3oD"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20001214005345.A3732@top.worldcontrol.com>; from brian@worldcontrol.com on Thu, Dec 14, 2000 at 12:53:46AM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ewQ5hdP4CtoTt3oD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2000 at 12:53:46AM -0800, brian@worldcontrol.com wrote:
> Sorry is this is too far off topic, but it seems to me the
> kernel may be helping in this break in or maybe some magic
> aspect of the filesystem.

I doubt that.... from this description, you've been hacked.  Even if your
/etc/inetd.conf is in good shape, it looks like someone got in.

I'm guessing that your ls was also hijacked.  You're using RedHat, so try
the rpm -V command to verify that the ls binary is the same as what should
be in the package.  While you're at it, verify the package is the right one
(compare to a CD or distr ftp site).

Out of curiosity, are you running portmap?  Perhaps BIND?  There are lots
of potential culprits here -- but I suggest you verify all of your binaries
and go back and upgrade everything on your system, as well as re-visit the
issue of what daemons are started up at boot time.

Matt Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

C:  They kicked your ass, didn't they?
S:  They were cheating!
					-- The Chief and Stef
User Friendly, 11/19/1997

--ewQ5hdP4CtoTt3oD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6OIuyz64nssGU+ykRAgKOAJ9CQIfz/aYVb5B6khFD4qJun8+QQQCg3gJ0
tcFKWQbBOGZXs5ij9jVLKeU=
=99Ft
-----END PGP SIGNATURE-----

--ewQ5hdP4CtoTt3oD--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
