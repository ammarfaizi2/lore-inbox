Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285416AbRLGFmQ>; Fri, 7 Dec 2001 00:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285417AbRLGFmG>; Fri, 7 Dec 2001 00:42:06 -0500
Received: from adsl-63-203-198-52.dsl.snfc21.pacbell.net ([63.203.198.52]:901
	"EHLO lame.durables.org") by vger.kernel.org with ESMTP
	id <S285416AbRLGFlV>; Fri, 7 Dec 2001 00:41:21 -0500
Subject: [PATCH] Sony DSC-F707 support in usb-storage
From: Robert Walsh <rjwalsh@durables.org>
To: mdharm-usb@one-eyed-alien.net
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-yqSp72ucjUMBaka/lPuK"
X-Mailer: Evolution/1.0 (Preview Release)
Date: 06 Dec 2001 21:41:19 -0800
Message-Id: <1007703679.3008.0.camel@spoon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yqSp72ucjUMBaka/lPuK
Content-Type: multipart/mixed; boundary="=-zt42cI/pN3s9t9Gpk7iF"


--=-zt42cI/pN3s9t9Gpk7iF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

This small patch against the 2.4.16 kernel allows the USB storage driver
to recognize the Sony DSC-F707 camera.

Regards,
 Robert.

--=20
Robert Walsh
Amalgamated Durables, Inc.  -  "We bring dead things to life"
Email: rjwalsh@durables.org

--=-zt42cI/pN3s9t9Gpk7iF
Content-Description: 
Content-Disposition: attachment; filename=f707patch
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- linux/drivers/usb/storage/unusual_devs.h	Thu Dec  6 17:35:08 2001
+++ linux-rj/drivers/usb/storage/unusual_devs.h	Thu Dec  6 17:35:20 2001
@@ -162,9 +162,9 @@
 		US_FL_SCM_MULT_TARG ),
=20
 /* This entry is needed because the device reports Sub=3Dff */
-UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0322,=20
+UNUSUAL_DEV(  0x054c, 0x0010, 0x0106, 0x0401,=20
 		"Sony",
-		"DSC-S30/S70/S75/505V/F505",=20
+		"DSC-S30/S70/S75/505V/F505/F707",=20
 		US_SC_SCSI, US_PR_CB, NULL,
 		US_FL_SINGLE_LUN | US_FL_START_STOP | US_FL_MODE_XLATE ),
=20

--=-zt42cI/pN3s9t9Gpk7iF--

--=-yqSp72ucjUMBaka/lPuK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8EFZ/bZtqSALM5CYRAvw1AJ9KCSeWYfSxm5pDImaT8VgHM8I0PwCdF5tA
s4ieSVIRonFBq7UK/TAAGJA=
=7ud9
-----END PGP SIGNATURE-----

--=-yqSp72ucjUMBaka/lPuK--

