Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRGDXtN>; Wed, 4 Jul 2001 19:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266581AbRGDXtD>; Wed, 4 Jul 2001 19:49:03 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:46347
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S266580AbRGDXst>; Wed, 4 Jul 2001 19:48:49 -0400
Date: Wed, 4 Jul 2001 16:48:48 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: ACPI in 2.4.6 detects power button twice
Message-ID: <20010704164848.A32536@one-eyed-alien.net>
Mail-Followup-To: Kernel Developer List <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I just installed 2.4.6, and turned ACPI on (and APM off).  On startup, APCI
reports "Power button: found" twice.  Also, in /proc/acpi/button there are
two directories named "power".

acpid is able to see the events properly, tho, and shutdown the computer.

This is a Tyan 1598S motherboard running an AMD K6-II 500MHz.  Will test
code to help get this fixed. :)

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Somebody call an exorcist!
					-- Dust Puppy
User Friendly, 5/16/1998

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Q6tgz64nssGU+ykRAt3FAJ4vNc3MsAXyz72ZAsNiFIrq9eM8TwCgsJBc
R6MbmwVzMyIqxqarFWK2FDI=
=VK9U
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
