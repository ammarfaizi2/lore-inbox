Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbTK1CXc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbTK1CWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:22:18 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:640 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261890AbTK1CWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:22:00 -0500
Date: Fri, 28 Nov 2003 03:00:03 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I4L] hfcpci missing MODULE_LICENSE
Message-ID: <20031128020003.GG1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

If this is compiled as a module and then loaded, the kernel is tainted
because of a missing module license.

Also,  according to  many european  laws, software  which  is released
under no license must not be used.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/hfcpci_lic=
ense.xml>

				Thunder

diff -Nur linux-2.6.0-test9-mm3/drivers/isdn/hisax/hisax_hfcpci.c linux-2.6=
=2E0-test9-mm3-ta1/drivers/isdn/hisax/hisax_hfcpci.c
--- linux-2.6.0-test9-mm3/drivers/isdn/hisax/hisax_hfcpci.c	2003-10-08 21:2=
4:04.000000000 +0200
+++ linux-2.6.0-test9-mm3-ta1/drivers/isdn/hisax/hisax_hfcpci.c	2003-11-24 =
13:30:53.000000000 +0100
@@ -35,6 +35,7 @@
 MODULE_PARM(debug, "i");
 #endif
=20
+MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kai Germaschewski <kai.germaschewski@gmx.de>/Werner Corneli=
us <werner@isdn4linux.de>");
 MODULE_DESCRIPTION("HFC PCI ISDN driver");
=20

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xqwjygQNIN66kP8RAuqMAJ9QRTuDb3LPCOumcxZWcp295xb6qwCeJpIK
eLB/1glKrPi9zXiPFyFQM4s=
=nTZJ
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
