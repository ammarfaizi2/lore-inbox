Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132559AbQLOHO4>; Fri, 15 Dec 2000 02:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131341AbQLOHOq>; Fri, 15 Dec 2000 02:14:46 -0500
Received: from ziggy.one-eyed-alien.net ([216.51.112.145]:44292 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S131966AbQLOHOa>; Fri, 15 Dec 2000 02:14:30 -0500
Date: Thu, 14 Dec 2000 22:44:03 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Anyone having trouble compiling test13-pre1?
Message-ID: <20001214224403.B25589@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having some problems with unresolved symbols in my modules with
test13-pre1.  This worked just fine before, and the symbols are all stuff
that I'm sure it there.

It looks like the modules were compiled for non-versioned symbols, while my
kernel uses versioned symbols.  The modules are looking for things like
daemonize, kmalloc, try_inc_mod_count, and other things I'd fully expect to
be there.  /proc/ksyms shows them as __VERSIONED_SYMBOL(daemonize), so I'm
not sure what to expect.

And yes, I'm running modutils 2.3.18.  Is anyone else seeing this, or am I
insane?

Matt

P.S. The test13-pre1 is still compiling (and installing modules, etc) as
2.4.0-test12.

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Pitr!  That's brilliant!  Funded by Microsoft refunds.  What sweet irony!
					-- A.J.
User Friendly, 2/15/1999

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6Ob2zz64nssGU+ykRAkZKAJ9UvREQgK5Sl3zi5eezJChDz42OAwCfeWfi
GXBuo0ET2XrFEEuPlOmQ/H0=
=tmuZ
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
