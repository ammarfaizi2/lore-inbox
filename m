Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUANGkf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 01:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUANGkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 01:40:35 -0500
Received: from mcgroarty.net ([64.81.147.195]:61312 "EHLO pinkbits.internal")
	by vger.kernel.org with ESMTP id S263632AbUANGkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 01:40:33 -0500
Date: Wed, 14 Jan 2004 00:40:32 -0600
To: linux-kernel@vger.kernel.org
Subject: USB KVM breaks under 2.6.0
Message-ID: <20040114064032.GA3247@mcgroarty.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
X-Debian-GNU-Linux: Rocks
From: Brian McGroarty <brian@mcgroarty.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I have a Belkin Omniview SE 4, a four port KVM, with keyboard and
mouse provided to a Linux box via USB.

Under 2.4.23, the device works well. The keyboard and mouse are
detected.

Under 2.6.0 (Debian build), the keyboard is not recognized.

I have verified that hid and usbkbd are loaded, and if I plug a USB
keyboard directly into the machine, the keyboard is recognized
properly.

/proc/bus/usb is empty -- with 2.4, I would have gone there to verify
that the device was seen. Is there any data I can pull from 2.6 which
might help diagnose this?

Is /proc/bus/input/handlers the proper analog?

pbit:/proc/bus/input# cat handlers
N: Number=0 Name=kbd

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFABORg2PBacobwYH4RAl3eAJ0ROswRsupi0Xw/ZpTYgBYxOe8GmACfXzth
voGXH+RuxA1zK+Bp+KDhxxk=
=H+4C
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
