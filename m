Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270253AbRIBG7i>; Sun, 2 Sep 2001 02:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271582AbRIBG73>; Sun, 2 Sep 2001 02:59:29 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:61965
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S270253AbRIBG7S>; Sun, 2 Sep 2001 02:59:18 -0400
Date: Sat, 1 Sep 2001 23:59:33 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
        Kernel Developer List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Johannes Erdfelt <johannes@erdfelt.com>,
        USB Storage List <usb-storage@one-eyed-alien.net>
Subject: PATCH: usb-storage: 1 of 3
Message-ID: <20010901235933.G4415@one-eyed-alien.net>
Mail-Followup-To: USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Kernel Developer List <linux-kernel@vger.redhat.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Johannes Erdfelt <johannes@erdfelt.com>,
	USB Storage List <usb-storage@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="X1xGqyAVbSpAWs5A"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1xGqyAVbSpAWs5A
Content-Type: multipart/mixed; boundary="V32M1hWVjliPHW+c"
Content-Disposition: inline


--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is a patch for the usb-storage driver.  Linus, please apply.

This patch adds a help entry for the configuration menu for a new
usb-storage sub-option.  The patch to add that sub-option is coming in a
few minutes.

Matt Dharm

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--V32M1hWVjliPHW+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.patch"
Content-Transfer-Encoding: quoted-printable

--- Documentation/Configure.help.old	Sat Sep  1 22:22:47 2001
+++ Documentation/Configure.help	Sat Sep  1 22:23:02 2001
@@ -11601,6 +11601,20 @@
   Say Y here in order to have the USB Mass Storage code generate
   verbose debugging messages.
=20
+ISD-200 USB/ATA driver
+CONFIG_USB_STORAGE_ISD200
+  Say Y here if you want to use USB Mass Store devices based
+  on the In-Systems Design ISD-200 USB/ATA bridge.
+
+  Some of the products that use this chip are:
+
+    - Archos Jukebox 6000
+    - ISD SmartCable for Storage
+    - Taiwan Skymaster CD530U/DEL-0241 IDE bridge
+    - Sony CRX10U CD-R/RW drive
+    - CyQ've CQ8060A CDRW drive
+    - Planex eXtreme Drive RX-25HU USB-IDE cable (not model RX-25U)
+
 USS720 parport driver
 CONFIG_USB_USS720
   This driver is for USB parallel port adapters that use the Lucent

--V32M1hWVjliPHW+c--

--X1xGqyAVbSpAWs5A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7kdjUz64nssGU+ykRAuPIAJ9G19TPZs12qlUa5RxCHXodZnmhWACeI+Ia
NMpOk3+QMyoP/cgkU1N3imY=
=VyX8
-----END PGP SIGNATURE-----

--X1xGqyAVbSpAWs5A--
