Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262780AbTC0CQX>; Wed, 26 Mar 2003 21:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262784AbTC0CQX>; Wed, 26 Mar 2003 21:16:23 -0500
Received: from adsl-67-121-155-183.dsl.pltn13.pacbell.net ([67.121.155.183]:13280
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id <S262780AbTC0CQW>; Wed, 26 Mar 2003 21:16:22 -0500
Date: Wed, 26 Mar 2003 18:27:32 -0800
To: James Simmons <jsimmons@infradead.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [REPRODUCABLE BUGS] Linux 2.5.66
Message-ID: <20030327022732.GA2867@triplehelix.org>
References: <1048722582.2039.11.camel@rohan.arnor.net> <Pine.LNX.4.44.0303270019050.25001-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303270019050.25001-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we're on the framebuffer bug train, James, do you know of
this bug with radeonfb:

My 2.5 kernel boots. Some initial boot text with ACPI and such is
scrolled on the screen, this is before radeonfb has taken over and
switched the screen size. But this is usually instant.

Right after the switch there is a lot of random characters in
varying colors at the top of the screen below the penguin. The
first legible boot message I see is this:

	"Console: switching to colour framebuffer device 128x48"

(not verbatim)

The junk quickly scrolls off into the sunset and has no adverse
effects on the following boot messages.

It does not help to tell lilo to use 1024x768x16 by default.
(vga=3D791)

This is a minor bug, but the same thing works fine in the 2.4
radeonfb.

Regards
Josh

--=20
New PGP public key: 0x27AFC3EE

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+gmGUT2bz5yevw+4RAofdAJ4kIdAYzxrHAjhW5IyOb411N/eFQgCgxkm6
Vjn5XL66TYBzSe7dtOooiOQ=
=ny+/
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
