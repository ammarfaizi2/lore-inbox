Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbUBFTkp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUBFTkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:40:45 -0500
Received: from [64.76.43.245] ([64.76.43.245]:53388 "EHLO smtp.bensa.ar")
	by vger.kernel.org with ESMTP id S265681AbUBFTkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:40:43 -0500
From: Norberto Bensa <nbensa@gmx.net>
To: Mark McClelland <mark@alpha.dyndns.org>
Subject: ov511: compression doesn't work with 2.6.x
Date: Fri, 6 Feb 2004 16:31:10 -0300
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_Eu+IANFciGPPplP";
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402061631.16123.nbensa@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_Eu+IANFciGPPplP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I'm trying to use my Creative WebCam III (CT6840) but if I enable compress=
=3D1 I=20
can't use the camera. Dmesg shows:

Linux video capture interface: v1.00
drivers/usb/media/ov511.c: USB OV511+ video device found
drivers/usb/media/ov511.c: model: Creative Labs WebCam 3
drivers/usb/media/ov511.c: Sensor is an OV7620
drivers/usb/media/ov511.c: Device at usb-0000:00:07.2-2 registered to minor=
 0
drivers/usb/core/usb.c: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
drivers/usb/media/ov511.c: No decompressor available
                           ^^^^^^^^^^^^^^^^^^^^^^^^^

No decompressor available? This worked with kernel 2.4.x=20

Many thanks in advance,
Norberto

=2D-=20
Linux 2.6.2-mm1 Pentium III (Coppermine) GenuineIntel GNU/Linux
 16:16:53 up  1:05,  1 user,  load average: 1.02, 0.64, 0.41

--Boundary-02=_Eu+IANFciGPPplP
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAI+uEFXVF50lmS74RAjEQAJ98hNCyPv7NSGQTrYC43cfoXyZf5wCeO/J9
DRhQL+SMIUUGQgJkFI+Syx4=
=nl4D
-----END PGP SIGNATURE-----

--Boundary-02=_Eu+IANFciGPPplP--
