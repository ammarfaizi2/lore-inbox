Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261372AbSKGUhO>; Thu, 7 Nov 2002 15:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261574AbSKGUhN>; Thu, 7 Nov 2002 15:37:13 -0500
Received: from ppp-217-133-220-172.dialup.tiscali.it ([217.133.220.172]:12424
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S261372AbSKGUhN>; Thu, 7 Nov 2002 15:37:13 -0500
Subject: Re: USB broken in 2.5.4[56]
From: Luca Barbieri <ldb@ldb.ods.org>
To: Greg KH <greg@kroah.com>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Linux-USB-Users <linux-usb-users@lists.sourceforge.net>
In-Reply-To: <20021106183046.GA23770@kroah.com>
References: <20021106132022.GA2101@home.ldb.ods.org> 
	<20021106183046.GA23770@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-EgDvU01NpHyeyhNl+vvP"
X-Mailer: Ximian Evolution 1.0.8 
Date: 07 Nov 2002 21:43:17 +0100
Message-Id: <1036701797.2841.17.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-EgDvU01NpHyeyhNl+vvP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

> Anyway, which USB drivers are you using?  That might help us narrow this
> down a bit.

speedtouch              8932   3
hid                    39652   0 (unused)
uhci-hcd               27900   0 (unused)
usbcore                88372   2 [speedtouch hid uhci-hcd]

Anyway the problems are obviously either in the USB core or in the uhci
driver.


--=-EgDvU01NpHyeyhNl+vvP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA9ytBldjkty3ft5+cRAhhwAJwPAsV0mEW+bS9dqo0WRdVVQl96pwCghS//
ZyN7isxHyJccurgMbSxluBU=
=/qxa
-----END PGP SIGNATURE-----

--=-EgDvU01NpHyeyhNl+vvP--
