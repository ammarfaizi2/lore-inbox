Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263056AbTE2WqI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 18:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTE2WqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 18:46:08 -0400
Received: from viriato2.servicios.retecal.es ([212.89.0.45]:3812 "EHLO
	viriato2.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S263056AbTE2WqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 18:46:06 -0400
Subject: [2.4.21-rc6][PATCH][TRIVIAL] Remove duplicate #define in
	include/linux/pci_ids.h
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-dvVRfWqZwTu5CG8XElqr"
Organization: 
Message-Id: <1054249161.2706.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 30 May 2003 00:59:22 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dvVRfWqZwTu5CG8XElqr
Content-Type: multipart/mixed; boundary="=-1ZeJ67uDNK2+bBBBKdXK"


--=-1ZeJ67uDNK2+bBBBKdXK
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello.

A simple trivial patch. Removes the duplicate entry for the same #define
--=20
/=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\
| Ram=F3n Rey Vicente <ramon.rey at hispalinux.es> |
|                                                |
| Jabber ID <rreylinux at jabber.org>            |
|                                                |
| Public GPG Key http://pgp.escomposlinux.org    |
|                                                |
| GLiSa http://glisa.hispalinux.es               |
\=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D/

--=-1ZeJ67uDNK2+bBBBKdXK
Content-Disposition: inline; filename=remove_duplicate_define_via_8377.diff
Content-Type: text/plain; name=remove_duplicate_define_via_8377.diff;
	charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

--- linux-2.4.20.orig/include/linux/pci_ids.h	2003-05-30 00:43:12.000000000=
 +0200
+++ linux-2.4.20/include/linux/pci_ids.h	2003-05-30 00:44:37.000000000 +020=
0
@@ -1029,7 +1029,6 @@
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
 #define PCI_DEVICE_ID_VIA_P4X333   0x3168
 #define PCI_DEVICE_ID_VIA_8235        0x3177
-#define PCI_DEVICE_ID_VIA_8377_0  0x3189
 #define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_8237     0x3227
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100

--=-1ZeJ67uDNK2+bBBBKdXK--

--=-dvVRfWqZwTu5CG8XElqr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+1pDJRGk68b69cdURAmGEAJwNvSR9iTuHKtzSlQIcRGZZNkRXzwCfRn7E
aqLQ04MCkX3WMOteb/6Jn/s=
=Zm1Q
-----END PGP SIGNATURE-----

--=-dvVRfWqZwTu5CG8XElqr--

