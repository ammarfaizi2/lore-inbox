Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTLaOYk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 09:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265066AbTLaOYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 09:24:40 -0500
Received: from smtp04.ya.com ([62.151.11.162]:2795 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S265060AbTLaOYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 09:24:37 -0500
Subject: kernel 2.6.0 UHCI-HCD && Mouse usb. Now it works
From: Carlos =?ISO-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Reply-To: lordeath@linuxspain.net
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-iilg7W1bVCuo8Y3WEcoW"
Organization: Torrejon Wireless
Message-Id: <1072880663.13237.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 31 Dec 2003 15:24:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-iilg7W1bVCuo8Y3WEcoW
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I've compiled 2.6.0-bk3, and I've probed to use my usb mouse, and now it
works :), Plugging and unplugging the device works good (no kernel
errors) and loading and unloading uhci-hcd now works good too :)

Thank you for all.=20


Now, when I plug in the device kernel shows that on messages:
(If it can help you)

Dec 31 15:06:49 kardon kernel: hub 2-0:1.0: new USB device on port 1,
assigned address 3
Dec 31 15:06:49 kardon kernel: [c9c5f240] link (09c5f1b2) element
(09faf080)
Dec 31 15:06:49 kardon kernel:  Element !=3D First TD
Dec 31 15:06:49 kardon kernel:   0: [c9faf040] link (09faf080) e3 LS
Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D3, PID=3D2d(SETUP) (buf=3D0a44520=
0)
Dec 31 15:06:49 kardon kernel:   1: [c9faf080] link (09faf0c0) e3 SPD LS
Stalled Babble Length=3D3 MaxLen=3D3 DT1 EndPt=3D0 Dev=3D3, PID=3D69(IN)
(buf=3D02d3da80)
Dec 31 15:06:49 kardon kernel:   2: [c9faf0c0] link (00000001) e3 LS IOC
Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D3, PID=3De1(OUT) (buf=3D=
00000000)
Dec 31 15:06:49 kardon kernel:
Dec 31 15:06:49 kardon kernel: usb 2-1: config 0 descriptor??
Dec 31 15:06:49 kardon kernel: [c9c5f270] link (09c5f1b2) element
(09faf2c0)
Dec 31 15:06:49 kardon kernel:  Element !=3D First TD
Dec 31 15:06:49 kardon kernel:   0: [c9faf280] link (09faf2c0) e3 LS
Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D3, PID=3D2d(SETUP) (buf=3D0a445c6=
0)
Dec 31 15:06:49 kardon kernel:   1: [c9faf2c0] link (09faf300) e3 SPD LS
Stalled Babble Length=3D3 MaxLen=3D3 DT1 EndPt=3D0 Dev=3D3, PID=3D69(IN)
(buf=3D059d6780)
Dec 31 15:06:49 kardon kernel:   2: [c9faf300] link (00000001) e3 LS IOC
Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D3, PID=3De1(OUT) (buf=3D=
00000000)
Dec 31 15:06:49 kardon kernel:
Dec 31 15:06:49 kardon kernel: [c9c5f240] link (09c5f1b2) element
(09faf080)
Dec 31 15:06:49 kardon kernel:  Element !=3D First TD
Dec 31 15:06:49 kardon kernel:   0: [c9faf040] link (09faf080) e3 LS
Length=3D7 MaxLen=3D7 DT0 EndPt=3D0 Dev=3D3, PID=3D2d(SETUP) (buf=3D09c8c06=
0)
Dec 31 15:06:49 kardon kernel:   1: [c9faf080] link (09faf0c0) e3 SPD LS
Stalled Babble Length=3D3 MaxLen=3D3 DT1 EndPt=3D0 Dev=3D3, PID=3D69(IN)
(buf=3D09c8c080)
Dec 31 15:06:49 kardon kernel:   2: [c9faf0c0] link (00000001) e3 LS IOC
Active Length=3D0 MaxLen=3D7ff DT1 EndPt=3D0 Dev=3D3, PID=3De1(OUT) (buf=3D=
00000000)
Dec 31 15:06:49 kardon kernel:
Dec 31 15:06:49 kardon kernel: drivers/usb/input/hid-core.c: ctrl urb
status -75 received
Dec 31 15:06:49 kardon kernel: input: USB HID v1.10 Mouse [062a:0000] on
usb-0000:00:1d.0-1


--=20
=C9ste correo esta firmado digitalmente, puedes importar mi clave con:
gpg --keyserver pgp.rediris.es --recv-keys 0xC0B6461F 0x4B2B2DEC


--=-iilg7W1bVCuo8Y3WEcoW
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/8twWno7DjsC2Rh8RAgEMAJ4tIYNoRq5EM0n1+CBJ4UGY5EtzFgCfXVRX
VeU6gQ61gI4DptNl+FIqrGY=
=B3jH
-----END PGP SIGNATURE-----

--=-iilg7W1bVCuo8Y3WEcoW--

