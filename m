Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263226AbUERMdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263226AbUERMdo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUERMdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:33:44 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:10250 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263226AbUERMdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:33:19 -0400
Date: Tue, 18 May 2004 14:33:15 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Sis900 bug fixes 4/4
Message-ID: <20040518123315.GG23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20040518120237.GC23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ISKrrfpKsPiF35CV"
Content-Disposition: inline
In-Reply-To: <20040518120237.GC23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ISKrrfpKsPiF35CV
Content-Type: multipart/mixed; boundary="GUPx2O/K0ibUojHx"
Content-Disposition: inline


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch 4 of 4

Small cleanup and spelling fixes of sis900.h (much more needed, also
in sis900.c, will go through Rusty's trivial patch monkey if my
maintainership is accepted).


Any comment is highly appreciated.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--GUPx2O/K0ibUojHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-header-cleanups.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.6/drivers/net/sis900.h	2004-05-18 11:44:24.000000000 +0200
+++ linux-sis900/drivers/net/sis900.h	2004-05-18 11:02:19.000000000 +0200
@@ -77,7 +77,7 @@
 	IE =3D 0x00000001
 };
=20
-/* maximum dma burst fro transmission and receive*/
+/* maximum dma burst for transmission and receive*/
 #define MAX_DMA_RANGE	7	/* actually 0 means MAXIMUM !! */
 #define TxMXDMA_shift   	20
 #define RxMXDMA_shift    20
@@ -86,7 +86,7 @@
 	DMA_BURST_512 =3D 0,	DMA_BURST_64 =3D 5
 };
=20
-/* transmit FIFO threshholds */
+/* transmit FIFO thresholds */
 #define TX_FILL_THRESH   16	/* 1/4 FIFO size */
 #define TxFILLT_shift   	8
 #define TxDRNT_shift    	0
@@ -140,7 +140,7 @@
 	EEREQ =3D 0x00000400, EEDONE =3D 0x00000200, EEGNT =3D 0x00000100
 };
=20
-/* Manamgement Data I/O (mdio) frame */
+/* Management Data I/O (mdio) frame */
 #define MIIread         0x6000
 #define MIIwrite        0x5002
 #define MIIpmdShift     7
@@ -277,6 +277,3 @@
 #define SIS630E_ISA_BRIDGE_ID_1	0x0008=09
 #define SIS630E_ISA_BRIDGE_ID_2	0x0018=09
=20
-/* PCI stuff, should be move to pci.h */
-#define SIS630_VENDOR_ID        0x1039
-#define SIS630_DEVICE_ID        0x0630

--GUPx2O/K0ibUojHx--

--ISKrrfpKsPiF35CV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqgKL2rmHZCWzV+0RAvO2AJ94283qx8UMD5l4UkJrZatGaehXVgCgqCMV
xGTgfMGZFiOYDIGypBcnAYI=
=X6/z
-----END PGP SIGNATURE-----

--ISKrrfpKsPiF35CV--
