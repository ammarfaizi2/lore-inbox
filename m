Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVDDS17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVDDS17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVDDS17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 14:27:59 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:10368 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261316AbVDDS1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 14:27:50 -0400
Date: Mon, 4 Apr 2005 11:27:49 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: mmap() and ioctl()
Message-ID: <20050404182749.GA6464@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This probably is a silly question, but....

Is is possible to open a file, mmap() it into memory, then pass the address
of that map via an ioctl() call to the kernel, which will copy_from_user()
that data?

Yeah, that's an odd concept, I know... I could always malloc() some
memory, read the file in, and then ioctl() it.  But, if I could get away
with a direct mmap(), that would be much better for me.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I say, what are all those naked people doing?
					-- Big client to Stef
User Friendly, 12/14/1997

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCUYclIjReC7bSPZARAu4rAJ4mz9HCgM/Tq8adYfN5ZfwF2RR8BACfTtp7
3jWB16hAdntWzLc2SFxx2D4=
=6UkS
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
