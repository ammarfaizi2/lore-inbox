Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbTGFABh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 20:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266562AbTGFABh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 20:01:37 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:5344
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S266567AbTGFABe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 20:01:34 -0400
Date: Sat, 5 Jul 2003 17:16:01 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>, ranty@debian.org
Subject: orinoco USB driver
Message-ID: <20030706001601.GA8592@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm currently trying to get my Avaya Wireless 'Silver' USB device to
work with the orinoco_usb driver v0.2.1.

Firstly, it is not 'supported.' So I had to use force_unsupported=3D1.
But the firmware you download is from Avaya's site, so it seems to me
like it should work!

Here's what i get:

firesong:/usr/src/orinoco-usb-0.2.1# modprobe orinoco_usb debug=3D1 force_u=
nsupported=3D1
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: Device is not supported (y=
ou may want to set force_unsupported=3D1)
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: Trying to handle device an=
yway as requested
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_probe: ENTER
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c: No firmware to download
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_remove_in_urb: no ur=
b to remove
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_delete: ENTER
unregister_netdevice: device wlan%d/cf4f3000 never was registered
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_delete: EXIT
/usr/src/orinoco-usb-0.2.1/driver/orinoco_usb.c:bridge_probe: EXIT
drivers/usb/core/usb.c: registered new driver Orinoco USB
orinoco_usb.c v0.2.1 (Manuel Estrada Sainz <ranty@debian.org>)

The light does not come on and I don't get any device. I notice that the
firmware is loaded from a .SYS file and installed into the hotplug
/usr/lib directory. When is this loaded?

Do you have any pointers? It would be really nice to get the card to
work!

Regards
Josh

--=20
"Notice that, written there, rather legibly, in the Baroque style common=20
to New York subway wall writers, was, uhm... was the old familiar=20
suggestion. And rather beautifully illustrated, as well..."

       -- Art Garfunkel on the inspiration for "A Poem On The Underground W=
all"

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/B2pBT2bz5yevw+4RAu8KAJ9VaaYz2eAzTHaPuTry/WL4Gh674wCfeVsN
V5uRqexL59TJ1LHT5gSYCrY=
=riMl
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
