Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVDRSwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVDRSwh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVDRSvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:51:41 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:2442 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262154AbVDRSuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:50:50 -0400
Subject: [PATCH 4/7] procfs privacy: /proc/bus & /proc/net directory entries
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ORO5tESuSbqOKgPU4x2g"
Date: Mon, 18 Apr 2005 20:49:12 +0200
Message-Id: <1113850153.17341.74.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ORO5tESuSbqOKgPU4x2g
Content-Type: multipart/mixed; boundary="=-a4dUnoF52D3jUlH8Fz4i"


--=-a4dUnoF52D3jUlH8Fz4i
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the /proc/net and /proc/bus
directory entries so non-root users are restricted from accessing them.

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_fs_proc_root.c.=
patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-a4dUnoF52D3jUlH8Fz4i
Content-Disposition: attachment; filename=proc-privacy-1_fs_proc_root.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_fs_proc_root.c.patch; charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGZzL3Byb2Mvcm9vdC5jfnByb2MtcHJpdmFjeS0xIGZzL3Byb2Mvcm9vdC5jDQot
LS0gbGludXgtMi42LjExL2ZzL3Byb2Mvcm9vdC5jfnByb2MtcHJpdmFjeS0xCTIwMDUtMDQtMTcg
MTg6MDI6MzguODMyOTExODQwICswMjAwDQorKysgbGludXgtMi42LjExLWxvcmVuem8vZnMvcHJv
Yy9yb290LmMJMjAwNS0wNC0xNyAxODowMzo1OS4xMDI3MDg5NzYgKzAyMDANCkBAIC01Miw3ICs1
Miw3IEBAIHZvaWQgX19pbml0IHByb2Nfcm9vdF9pbml0KHZvaWQpDQogCQlyZXR1cm47DQogCX0N
CiAJcHJvY19taXNjX2luaXQoKTsNCi0JcHJvY19uZXQgPSBwcm9jX21rZGlyKCJuZXQiLCBOVUxM
KTsNCisJcHJvY19uZXQgPSBwcm9jX21rZGlyX21vZGUoIm5ldCIsIFNfSVJVU1IgfCBTX0lYVVNS
LCBOVUxMKTsNCiAJcHJvY19uZXRfc3RhdCA9IHByb2NfbWtkaXIoIm5ldC9zdGF0IiwgTlVMTCk7
DQogDQogI2lmZGVmIENPTkZJR19TWVNWSVBDDQpAQCAtNzYsNyArNzYsNyBAQCB2b2lkIF9faW5p
dCBwcm9jX3Jvb3RfaW5pdCh2b2lkKQ0KICNpZmRlZiBDT05GSUdfUFJPQ19ERVZJQ0VUUkVFDQog
CXByb2NfZGV2aWNlX3RyZWVfaW5pdCgpOw0KICNlbmRpZg0KLQlwcm9jX2J1cyA9IHByb2NfbWtk
aXIoImJ1cyIsIE5VTEwpOw0KKwlwcm9jX2J1cyA9IHByb2NfbWtkaXJfbW9kZSgiYnVzIiwgU19J
UlVTUiB8IFNfSVhVU1IsIE5VTEwpOw0KIH0NCiANCiBzdGF0aWMgc3RydWN0IGRlbnRyeSAqcHJv
Y19yb290X2xvb2t1cChzdHJ1Y3QgaW5vZGUgKiBkaXIsIHN0cnVjdCBkZW50cnkgKiBkZW50cnks
IHN0cnVjdCBuYW1laWRhdGEgKm5kKQ0K


--=-a4dUnoF52D3jUlH8Fz4i--

--=-ORO5tESuSbqOKgPU4x2g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZAEoDcEopW8rLewRAvE+AJ9IhjT49d16Sp0xDfHvekBKustBrwCgoyLC
l7VRIyj5PKlIdGZL1RldAjo=
=QZY6
-----END PGP SIGNATURE-----

--=-ORO5tESuSbqOKgPU4x2g--

