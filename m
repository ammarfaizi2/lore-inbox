Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUBVIUG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 03:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUBVIUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 03:20:06 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:59268 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261194AbUBVIUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 03:20:01 -0500
Date: Sun, 22 Feb 2004 00:19:59 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: 2.6 build oddity...
Message-ID: <20040222081959.GA21170@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm not sure where to report this....

In some sort of freak accident, I had a .s file in my source tree.
Whenever I did a build (make bzImage modules), the build process would:
(1) check out the corresponding .c file
(2) build the .s into the .o
(3) delete the .c file

Which I find odd, because:
(1) It never used the .c file, but checked it out anyway
(2) It _did_ delete the .c file, without using it

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

G:  Let me guess, you started on the 'net with AOL, right?
C:  WOW! d00d! U r leet!
					-- Greg and Customer=20
User Friendly, 2/12/1999

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAOGYvIjReC7bSPZARAtpwAJ9Dkr2XemNJAX1jnWgwPOXYNyCkmQCdErPA
t1uSnL1uSgwT5a/HqMF+DvE=
=3jGc
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
