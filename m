Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315503AbSHBPsQ>; Fri, 2 Aug 2002 11:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315513AbSHBPsP>; Fri, 2 Aug 2002 11:48:15 -0400
Received: from noose.gt.owl.de ([62.52.19.4]:40970 "HELO noose.gt.owl.de")
	by vger.kernel.org with SMTP id <S315503AbSHBPsO>;
	Fri, 2 Aug 2002 11:48:14 -0400
Date: Fri, 2 Aug 2002 17:51:41 +0200
From: Florian Lohoff <flo@rfc822.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19-rc5 cyclades.c one liner
Message-ID: <20020802155141.GB26459@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,
i dont think this is left over intentionally - At least it breaks the
Cyclades-Z=20

diff -Nur linux-2.4.19-rc5/drivers/char/cyclades.c linux/drivers/char/cycla=
des.c
--- linux-2.4.19-rc5/drivers/char/cyclades.c	Mon Feb 25 19:37:57 2002
+++ linux/drivers/char/cyclades.c	Fri Aug  2 15:45:38 2002
@@ -5175,7 +5175,6 @@
 		/* Although we don't use this I/O region, we should
 		   request it from the kernel anyway, to avoid problems
 		   with other drivers accessing it. */
-		request_region(cy_pci_phys1, CyPCI_Zctl, "Cyclades-Z");
 		resource =3D request_region(cy_pci_phys1, CyPCI_Zctl,=20
 					  "Cyclades-Z");
 		if (resource =3D=3D NULL) {

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9SqqNUaz2rXW+gJcRAkCrAJ0SZKI60R2cyiNEfMJA1Mysf1xoZACg2a2S
4yXAfNIYDvpioZotusIf8r8=
=XKOo
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
