Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVDRSwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVDRSwi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 14:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDRSva
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 14:51:30 -0400
Received: from vds-320151.amen-pro.com ([62.193.204.86]:59273 "EHLO
	vds-320151.amen-pro.com") by vger.kernel.org with ESMTP
	id S262151AbVDRSut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 14:50:49 -0400
Subject: [PATCH 3/7] procfs privacy: misc. entries
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?=
	 =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-FK1VJtOA8AgPtOmpe9TD"
Date: Mon, 18 Apr 2005 20:46:52 +0200
Message-Id: <1113850012.17341.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FK1VJtOA8AgPtOmpe9TD
Content-Type: multipart/mixed; boundary="=-fd5RBa8zc7ai2yIGuFZ6"


--=-fd5RBa8zc7ai2yIGuFZ6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This patch changes the permissions of the following procfs entries to
restrict non-root users from accessing them:

 - /proc/devices=20
 - /proc/cmdline
 - /proc/version
 - /proc/uptime
 - /proc/cpuinfo
 - /proc/partitions
 - /proc/stat
 - /proc/interrupts
 - /proc/slabinfo
 - /proc/diskstats
 - /proc/modules
 - /proc/schedstat

It's also available at:
http://pearls.tuxedo-es.org/patches/security/proc-privacy-1_fs_proc_proc_mi=
sc.c.patch

--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-fd5RBa8zc7ai2yIGuFZ6
Content-Disposition: attachment; filename=proc-privacy-1_fs_proc_proc_misc.c.patch
Content-Type: text/x-patch; name=proc-privacy-1_fs_proc_proc_misc.c.patch; charset=us-ascii
Content-Transfer-Encoding: base64

ZGlmZiAtcHVOIGZzL3Byb2MvcHJvY19taXNjLmN+cHJvYy1wcml2YWN5LTEgZnMvcHJvYy9wcm9j
X21pc2MuYw0KLS0tIGxpbnV4LTIuNi4xMS9mcy9wcm9jL3Byb2NfbWlzYy5jfnByb2MtcHJpdmFj
eS0xCTIwMDUtMDQtMTcgMTg6MDk6NDAuNjE1NzkxMDk2ICswMjAwDQorKysgbGludXgtMi42LjEx
LWxvcmVuem8vZnMvcHJvYy9wcm9jX21pc2MuYwkyMDA1LTA0LTE3IDE4OjIwOjEzLjc2MzUzODAw
OCArMDIwMA0KQEAgLTU1MiwxOCArNTUyLDE0IEBAIHZvaWQgX19pbml0IHByb2NfbWlzY19pbml0
KHZvaWQpDQogCQlpbnQgKCpyZWFkX3Byb2MpKGNoYXIqLGNoYXIqKixvZmZfdCxpbnQsaW50Kix2
b2lkKik7DQogCX0gKnAsIHNpbXBsZV9vbmVzW10gPSB7DQogCQl7ImxvYWRhdmciLCAgICAgbG9h
ZGF2Z19yZWFkX3Byb2N9LA0KLQkJeyJ1cHRpbWUiLAl1cHRpbWVfcmVhZF9wcm9jfSwNCiAJCXsi
bWVtaW5mbyIsCW1lbWluZm9fcmVhZF9wcm9jfSwNCi0JCXsidmVyc2lvbiIsCXZlcnNpb25fcmVh
ZF9wcm9jfSwNCiAjaWZkZWYgQ09ORklHX1BST0NfSEFSRFdBUkUNCiAJCXsiaGFyZHdhcmUiLAlo
YXJkd2FyZV9yZWFkX3Byb2N9LA0KICNlbmRpZg0KICNpZmRlZiBDT05GSUdfU1RSQU1fUFJPQw0K
IAkJeyJzdHJhbSIsCXN0cmFtX3JlYWRfcHJvY30sDQogI2VuZGlmDQotCQl7ImRldmljZXMiLAlk
ZXZpY2VzX3JlYWRfcHJvY30sDQogCQl7ImZpbGVzeXN0ZW1zIiwJZmlsZXN5c3RlbXNfcmVhZF9w
cm9jfSwNCi0JCXsiY21kbGluZSIsCWNtZGxpbmVfcmVhZF9wcm9jfSwNCiAJCXsibG9ja3MiLAls
b2Nrc19yZWFkX3Byb2N9LA0KIAkJeyJleGVjZG9tYWlucyIsCWV4ZWNkb21haW5zX3JlYWRfcHJv
Y30sDQogCQl7TlVMTCx9DQpAQCAtNTcxLDI1ICs1NjcsMzAgQEAgdm9pZCBfX2luaXQgcHJvY19t
aXNjX2luaXQodm9pZCkNCiAJZm9yIChwID0gc2ltcGxlX29uZXM7IHAtPm5hbWU7IHArKykNCiAJ
CWNyZWF0ZV9wcm9jX3JlYWRfZW50cnkocC0+bmFtZSwgMCwgTlVMTCwgcC0+cmVhZF9wcm9jLCBO
VUxMKTsNCiANCisJY3JlYXRlX3Byb2NfcmVhZF9lbnRyeSgiZGV2aWNlcyIsIFNfSVJVU1IsIE5V
TEwsICZkZXZpY2VzX3JlYWRfcHJvYywgTlVMTCk7DQorCWNyZWF0ZV9wcm9jX3JlYWRfZW50cnko
ImNtZGxpbmUiLCBTX0lSVVNSLCBOVUxMLCAmY21kbGluZV9yZWFkX3Byb2MsIE5VTEwpOw0KKwlj
cmVhdGVfcHJvY19yZWFkX2VudHJ5KCJ2ZXJzaW9uIiwgU19JUlVTUiwgTlVMTCwgJnZlcnNpb25f
cmVhZF9wcm9jLCBOVUxMKTsNCisJY3JlYXRlX3Byb2NfcmVhZF9lbnRyeSgidXB0aW1lIiwgU19J
UlVTUiwgTlVMTCwgJnVwdGltZV9yZWFkX3Byb2MsIE5VTEwpOw0KKw0KIAlwcm9jX3N5bWxpbmso
Im1vdW50cyIsIE5VTEwsICJzZWxmL21vdW50cyIpOw0KIA0KIAkvKiBBbmQgbm93IGZvciB0cmlj
a2llciBvbmVzICovDQogCWVudHJ5ID0gY3JlYXRlX3Byb2NfZW50cnkoImttc2ciLCBTX0lSVVNS
LCAmcHJvY19yb290KTsNCiAJaWYgKGVudHJ5KQ0KIAkJZW50cnktPnByb2NfZm9wcyA9ICZwcm9j
X2ttc2dfb3BlcmF0aW9uczsNCi0JY3JlYXRlX3NlcV9lbnRyeSgiY3B1aW5mbyIsIDAsICZwcm9j
X2NwdWluZm9fb3BlcmF0aW9ucyk7DQotCWNyZWF0ZV9zZXFfZW50cnkoInBhcnRpdGlvbnMiLCAw
LCAmcHJvY19wYXJ0aXRpb25zX29wZXJhdGlvbnMpOw0KLQljcmVhdGVfc2VxX2VudHJ5KCJzdGF0
IiwgMCwgJnByb2Nfc3RhdF9vcGVyYXRpb25zKTsNCi0JY3JlYXRlX3NlcV9lbnRyeSgiaW50ZXJy
dXB0cyIsIDAsICZwcm9jX2ludGVycnVwdHNfb3BlcmF0aW9ucyk7DQotCWNyZWF0ZV9zZXFfZW50
cnkoInNsYWJpbmZvIixTX0lXVVNSfFNfSVJVR08sJnByb2Nfc2xhYmluZm9fb3BlcmF0aW9ucyk7
DQorCWNyZWF0ZV9zZXFfZW50cnkoImNwdWluZm8iLCBTX0lSVVNSLCAmcHJvY19jcHVpbmZvX29w
ZXJhdGlvbnMpOw0KKwljcmVhdGVfc2VxX2VudHJ5KCJwYXJ0aXRpb25zIiwgU19JUlVTUiwgJnBy
b2NfcGFydGl0aW9uc19vcGVyYXRpb25zKTsNCisJY3JlYXRlX3NlcV9lbnRyeSgic3RhdCIsIFNf
SVJVU1IsICZwcm9jX3N0YXRfb3BlcmF0aW9ucyk7DQorCWNyZWF0ZV9zZXFfZW50cnkoImludGVy
cnVwdHMiLCBTX0lSVVNSLCAmcHJvY19pbnRlcnJ1cHRzX29wZXJhdGlvbnMpOw0KKwljcmVhdGVf
c2VxX2VudHJ5KCJzbGFiaW5mbyIsU19JV1VTUnxTX0lSVVNSLCZwcm9jX3NsYWJpbmZvX29wZXJh
dGlvbnMpOw0KIAljcmVhdGVfc2VxX2VudHJ5KCJidWRkeWluZm8iLFNfSVJVR08sICZmcmFnbWVu
dGF0aW9uX2ZpbGVfb3BlcmF0aW9ucyk7DQogCWNyZWF0ZV9zZXFfZW50cnkoInZtc3RhdCIsU19J
UlVHTywgJnByb2Nfdm1zdGF0X2ZpbGVfb3BlcmF0aW9ucyk7DQotCWNyZWF0ZV9zZXFfZW50cnko
ImRpc2tzdGF0cyIsIDAsICZwcm9jX2Rpc2tzdGF0c19vcGVyYXRpb25zKTsNCisJY3JlYXRlX3Nl
cV9lbnRyeSgiZGlza3N0YXRzIiwgU19JUlVTUiwgJnByb2NfZGlza3N0YXRzX29wZXJhdGlvbnMp
Ow0KICNpZmRlZiBDT05GSUdfTU9EVUxFUw0KLQljcmVhdGVfc2VxX2VudHJ5KCJtb2R1bGVzIiwg
MCwgJnByb2NfbW9kdWxlc19vcGVyYXRpb25zKTsNCisJY3JlYXRlX3NlcV9lbnRyeSgibW9kdWxl
cyIsIFNfSVJVU1IsICZwcm9jX21vZHVsZXNfb3BlcmF0aW9ucyk7DQogI2VuZGlmDQogI2lmZGVm
IENPTkZJR19TQ0hFRFNUQVRTDQotCWNyZWF0ZV9zZXFfZW50cnkoInNjaGVkc3RhdCIsIDAsICZw
cm9jX3NjaGVkc3RhdF9vcGVyYXRpb25zKTsNCisJY3JlYXRlX3NlcV9lbnRyeSgic2NoZWRzdGF0
IiwgU19JUlVTUiwgJnByb2Nfc2NoZWRzdGF0X29wZXJhdGlvbnMpOw0KICNlbmRpZg0KICNpZmRl
ZiBDT05GSUdfUFJPQ19LQ09SRQ0KIAlwcm9jX3Jvb3Rfa2NvcmUgPSBjcmVhdGVfcHJvY19lbnRy
eSgia2NvcmUiLCBTX0lSVVNSLCBOVUxMKTsNCl8NCg==


--=-fd5RBa8zc7ai2yIGuFZ6--

--=-FK1VJtOA8AgPtOmpe9TD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCZACcDcEopW8rLewRAjHUAJ0dM+c2fAxpNBFlhccK9FhpTUnNGACg0Icu
+XunQc/YaQluV+iWj5zuKRo=
=90G5
-----END PGP SIGNATURE-----

--=-FK1VJtOA8AgPtOmpe9TD--

