Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUAHF1A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 00:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263792AbUAHF1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 00:27:00 -0500
Received: from mail.donpac.ru ([80.254.111.2]:62413 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263772AbUAHF0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 00:26:54 -0500
Date: Thu, 8 Jan 2004 08:26:40 +0300
From: Andrey Panin <pazke@donpac.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-visws@lists.sf.net
Subject: [PATCH] MSI broke visws build
Message-ID: <20040108052640.GB16362@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-visws@lists.sf.net
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: multipart/mixed; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,=20

attached patch fixes visws builb which wassss broken by
PCI MSI support merge.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-visws-2.6.1"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/include/asm-i386=
/mach-visws/irq_vectors.h linux-2.6.0-test3/include/asm-i386/mach-visws/irq=
_vectors.h
--- linux-2.6.0-test3.vanilla/include/asm-i386/mach-visws/irq_vectors.h	200=
4-01-01 17:07:40.000000000 +0300
+++ linux-2.6.0-test3/include/asm-i386/mach-visws/irq_vectors.h	2004-01-07 =
13:58:44.000000000 +0300
@@ -1,6 +1,8 @@
 #ifndef _ASM_IRQ_VECTORS_H
 #define _ASM_IRQ_VECTORS_H
=20
+#define NR_VECTORS 256
+
 /*
  * IDT vectors usable for external interrupt sources start
  * at 0x20:

--dTy3Mrz/UPE2dbVg--

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//OoPby9O0+A2ZecRAsfUAJ98i584oEcgI2Camox6/1uDQq1NhACfbGAy
7T+zQqhNhk8qyv0TwbLVzbI=
=m/lQ
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
