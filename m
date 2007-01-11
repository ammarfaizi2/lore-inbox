Return-Path: <linux-kernel-owner+w=401wt.eu-S1750936AbXAKRUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbXAKRUu (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbXAKRUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:20:49 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:51786 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750901AbXAKRUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:20:49 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: linux-kernel@vger.kernel.org
Subject: 2.6.20-rc4: usb somehow broken
Date: Thu, 11 Jan 2007 18:20:45 +0100
User-Agent: KMail/1.9.5
Cc: linux-usb-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7214728.e7888V4X8d";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200701111820.46121.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart7214728.e7888V4X8d
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

I can't scan anymore. :-( I don't know which rc kernel introduced it, but t=
his=20
are the messages I get (w/o touching the device/usb cable except pluggin it=
=20
in for the first time):

usb 1-1.2: new full speed USB device using ehci_hcd and address 4
ehci_hcd 0000:00:0b.1: qh ffff81007bc6c280 (#00) state 4
usb 1-1.2: configuration #1 chosen from 1 choice
usb 1-1.2: USB disconnect, address 4
usb 1-1.2: new full speed USB device using ehci_hcd and address 5
usb 1-1.2: configuration #1 chosen from 1 choice
usb 1-1.2: USB disconnect, address 5
usb 1-1.2: new full speed USB device using ehci_hcd and address 6
usb 1-1.2: configuration #1 chosen from 1 choice
usb 1-1.2: USB disconnect, address 6
usb 1-1.2: new full speed USB device using ehci_hcd and address 7
usb 1-1.2: configuration #1 chosen from 1 choice
usb 1-1.2: USB disconnect, address 7
usb 1-1.2: new full speed USB device using ehci_hcd and address 8
usb 1-1.2: configuration #1 chosen from 1 choice


Shouldn't the ohci module handle the scanner? The scanner is connected thro=
ugh=20
a hub.

I don't remember how 2.6.19 handled it, or whether I used some new exotic=20
setting which causes the breakage.

Well, I'll test this week-end and upload more infos then. If you already ha=
ve=20
some ideas in the meantime, let me know.

BTW, a usb2.0 card reader (connected through the same hub) works w/o=20
problems...
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart7214728.e7888V4X8d
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iD8DBQBFpnHuxU2n/+9+t5gRAnN6AJwLZh5ABdTfKfhrJcUXUAcv6hdcvgCgyF2C
Lds7IxPkjFMMydgDZ7NMIgE=
=O+Ct
-----END PGP SIGNATURE-----

--nextPart7214728.e7888V4X8d--
