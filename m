Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWDVTI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWDVTI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWDVTI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:08:58 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:12471 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750947AbWDVTI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:08:57 -0400
Message-ID: <4449CB69.20907@t-online.de>
Date: Sat, 22 Apr 2006 08:21:29 +0200
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mail/News 1.5 (X11/20060325)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.9, amd64, usbcore: NULL pointer dereference
References: <4448FCC7.6070309@t-online.de>
In-Reply-To: <4448FCC7.6070309@t-online.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig352E193A72554E5084F936BB"
X-ID: ZqYoy0Zv8e3DqGMnkxOPbVag4K0CpdUWYNivt8rBzHc+pCaLf+w9kv
X-TOI-MSGID: 9ca9ee04-002f-4070-9a88-2b95fa90c79f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig352E193A72554E5084F936BB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

PS: I should mention that I had an USB disk attached at
boot time.

Harald Dunkel wrote:
>=20
> # lsusb
> Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 C=
ard Reader
> Bus 003 Device 002: ID 0ace:1211 ZyDAS 802.11b/g USB2 WiFi
> Bus 003 Device 004: ID 124a:4023 AirVast
> Bus 003 Device 001: ID 0000:0000
> Bus 002 Device 001: ID 0000:0000
> Bus 001 Device 001: ID 0000:0000
>=20

It should appear in the output of lsusb, too. If I insert
a SD card before booting, then I get:

# lsusb
Bus 003 Device 003: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 Car=
d Reader
Bus 003 Device 001: ID 0000:0000
Bus 003 Device 002: ID 0ace:1211 ZyDAS 802.11b/g USB2 WiFi
Bus 003 Device 004: ID 124a:4023 AirVast
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000


Regards

Harri



--------------enig352E193A72554E5084F936BB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESctpUTlbRTxpHjcRAgpXAJ4+yRjaQv2llH72XdPIFbbI6bhBggCcCppZ
OxAwawaBCoYHfgHmHL6WkvE=
=ChoU
-----END PGP SIGNATURE-----

--------------enig352E193A72554E5084F936BB--
