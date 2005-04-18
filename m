Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262150AbVDRSvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262150AbVDRSvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDRSvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:51:08 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:38793 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262150AbVDRSuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:50:44 -0400
Subject: [PATCH 2/7] procfs privacy: tasks/processes lookup
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uba6PO0g84cDgGsV2LrP"
Date: Mon, 18 Apr 2005 20:46:33 +0200
Message-Id: <1113849993.17341.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-uba6PO0g84cDgGsV2LrP
Content-Type: multipart/mixed; boundary="=-KPP1Az1xcm3fi98ZHSiL"


--=-KPP1Az1xcm3fi98ZHSiL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch restricts non-root users to view only their own processes.

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_fs_proc_base.c.=
patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-KPP1Az1xcm3fi98ZHSiL
Content-Disposition: attachment; filename=proc-privacy-1_fs_proc_base.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_fs_proc_base.c.patch; charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGZzL3Byb2MvYmFzZS5jfnByb2MtcHJpdmFjeS0xIGZzL3Byb2MvYmFzZS5jDQot
LS0gbGludXgtMi42LjExL2ZzL3Byb2MvYmFzZS5jfnByb2MtcHJpdmFjeS0xCTIwMDUtMDQtMTcg
MTc6NTY6NDUuNjIzNjA3ODE2ICswMjAwDQorKysgbGludXgtMi42LjExLWxvcmVuem8vZnMvcHJv
Yy9iYXNlLmMJMjAwNS0wNC0xNyAxODowMToxNC45ODg2NTgxMDQgKzAyMDANCkBAIC0xNjkyLDYg
KzE2OTIsMTEgQEAgc3RydWN0IGRlbnRyeSAqcHJvY19waWRfbG9va3VwKHN0cnVjdCBpbg0KIAlp
ZiAoIXRhc2spDQogCQlnb3RvIG91dDsNCiANCisJaWYgKGN1cnJlbnQtPnVpZCAmJiAodGFzay0+
dWlkICE9IGN1cnJlbnQtPnVpZCkpIHsNCisJCXB1dF90YXNrX3N0cnVjdCh0YXNrKTsNCisJCWdv
dG8gb3V0Ow0KKwl9DQorDQogCWlub2RlID0gcHJvY19waWRfbWFrZV9pbm9kZShkaXItPmlfc2Is
IHRhc2ssIFBST0NfVEdJRF9JTk8pOw0KIA0KIA0KQEAgLTE2OTksNyArMTcwNCw3IEBAIHN0cnVj
dCBkZW50cnkgKnByb2NfcGlkX2xvb2t1cChzdHJ1Y3QgaW4NCiAJCXB1dF90YXNrX3N0cnVjdCh0
YXNrKTsNCiAJCWdvdG8gb3V0Ow0KIAl9DQotCWlub2RlLT5pX21vZGUgPSBTX0lGRElSfFNfSVJV
R098U19JWFVHTzsNCisJaW5vZGUtPmlfbW9kZSA9IFNfSUZESVJ8U19JUlVTUnxTX0lYVVNSOw0K
IAlpbm9kZS0+aV9vcCA9ICZwcm9jX3RnaWRfYmFzZV9pbm9kZV9vcGVyYXRpb25zOw0KIAlpbm9k
ZS0+aV9mb3AgPSAmcHJvY190Z2lkX2Jhc2Vfb3BlcmF0aW9uczsNCiAJaW5vZGUtPmlfbmxpbmsg
PSAzOw0KQEAgLTE3ODMsNiArMTc4OCw3IEBAIG91dDoNCiBzdGF0aWMgaW50IGdldF90Z2lkX2xp
c3QoaW50IGluZGV4LCB1bnNpZ25lZCBsb25nIHZlcnNpb24sIHVuc2lnbmVkIGludCAqdGdpZHMp
DQogew0KIAlzdHJ1Y3QgdGFza19zdHJ1Y3QgKnA7DQorCXN0cnVjdCB0YXNrX3N0cnVjdCAqdG1w
ID0gY3VycmVudDsNCiAJaW50IG5yX3RnaWRzID0gMDsNCiANCiAJaW5kZXgtLTsNCkBAIC0xODAz
LDYgKzE4MDksOCBAQCBzdGF0aWMgaW50IGdldF90Z2lkX2xpc3QoaW50IGluZGV4LCB1bnNpDQog
CQlpbnQgdGdpZCA9IHAtPnBpZDsNCiAJCWlmICghcGlkX2FsaXZlKHApKQ0KIAkJCWNvbnRpbnVl
Ow0KKwkJaWYgKHRtcC0+dWlkICYmIChwLT51aWQgIT0gdG1wLT51aWQpKQ0KKwkJCWNvbnRpbnVl
Ow0KIAkJaWYgKC0taW5kZXggPj0gMCkNCiAJCQljb250aW51ZTsNCiAJCXRnaWRzW25yX3RnaWRz
XSA9IHRnaWQ7DQo=


--=-KPP1Az1xcm3fi98ZHSiL--

--=-uba6PO0g84cDgGsV2LrP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZACJDcEopW8rLewRAtYfAJ4u+yLS5pVMxc0qpC/UxU6zgpqzwACfQLb1
BWVomJEH+8LG+1ONQTh9xw8=
=Xjqq
-----END PGP SIGNATURE-----

--=-uba6PO0g84cDgGsV2LrP--

