Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270218AbRHGX3w>; Tue, 7 Aug 2001 19:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270219AbRHGX3m>; Tue, 7 Aug 2001 19:29:42 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:10003
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S270218AbRHGX3a>; Tue, 7 Aug 2001 19:29:30 -0400
Date: Tue, 7 Aug 2001 16:29:39 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: using mount from SUID scripts?
Message-ID: <20010807162939.A26249@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've got an SUID perl script (yes, it's EUID is really 0) which I'd like to
use mount from to mount a file via loopback...

Unfortunately, it looks like mount refuses to actually mount anything if
the EUID and UID aren't the same....

Does anyone happen to know a way around this?  Yes, I know this isn't the
most secure thing in the world... but I'm basically trying to build a
filesystem image and put stuff on it using dd, mkfs, mount, and cp.  It all
works great when run as root, but it really needs to be useable as a
typical user.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7cHnjz64nssGU+ykRAmhZAKDIMIx5M8fUk5AkT+EeIRHCOCLd9ACgnkDz
mgMYY1cXwHFyvZaWem+W3p4=
=JJ+P
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
