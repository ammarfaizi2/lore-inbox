Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbTJ2Btk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 20:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTJ2Btk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 20:49:40 -0500
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:21906 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261869AbTJ2Bti
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 20:49:38 -0500
Subject: [PATCH] Re: PS/2 Slowness w/ 2.6.0-test9-bk2
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <rrey@ranty.pantax.net>
Reply-To: ramon.rey@hispalinux.es
To: walt <wa1ter@myrealbox.com>
Cc: Shawn Starr <spstarr@sh0n.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3F9F0E72.2010606@myrealbox.com>
References: <fa.k5maq39.1h6g0b7@ifi.uio.no> <3F9F0E72.2010606@myrealbox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HWh3NqC9JrKW5+Uv+Rv7"
Message-Id: <1067392135.1052.4.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 29 Oct 2003 02:48:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HWh3NqC9JrKW5+Uv+Rv7
Content-Type: multipart/mixed; boundary="=-jHE22hNutbrLEL6rwEL3"


--=-jHE22hNutbrLEL6rwEL3
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

El mi=E9, 29-10-2003 a las 01:48, walt escribi=F3:

> I have the same problem, but I find that booting with the psmouse_noext
> kernel parameter reverses the unwanted behavior.

I've made a patch with a workaround, a new MOUSE_PS2_FORCE_RATE option
:). I hope this help somebody while Linus/someone find the perfect
solution
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/

--=-jHE22hNutbrLEL6rwEL3
Content-Disposition: inline; filename=mouse_ps2_force_rate.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=mouse_ps2_force_rate.patch; charset=iso-8859-15

SW5kZXg6IEtjb25maWcNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBLY29uZmlnCShyZXZpc2lvbiAxMzY3NCkN
CisrKyBLY29uZmlnCSh3b3JraW5nIGNvcHkpDQpAQCAtMjgsNiArMjgsMTMgQEANCiAJICBUbyBj
b21waWxlIHRoaXMgZHJpdmVyIGFzIGEgbW9kdWxlLCBjaG9vc2UgTSBoZXJlOiB0aGUNCiAJICBt
b2R1bGUgd2lsbCBiZSBjYWxsZWQgcHNtb3VzZS4NCiANCitjb25maWcgTU9VU0VfUFMyX0ZPUkNF
X1JBVEUNCisJYm9vbCAiRm9yY2UgcmF0ZSBvZiBQUy8yIG1vdXNlIg0KKwlkZWZhdWx0IG4NCisJ
ZGVwZW5kcyBvbiBNT1VTRV9QUzINCisJLS0taGVscC0tLQ0KKwkgIFNheSBZIGlmIHlvdSBleHBl
cmltZW50IHNsb3duZXNzIHByb2JsZW1zIHdpdGggeW91ciBQUy8yIG1vdXNlLg0KKw0KIGNvbmZp
ZyBNT1VTRV9QUzJfU1lOQVBUSUNTDQogCWJvb2wgIlN5bmFwdGljcyBUb3VjaFBhZCINCiAJZGVm
YXVsdCBuDQpJbmRleDogcHNtb3VzZS1iYXNlLmMNCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCi0tLSBwc21vdXNlLWJh
c2UuYwkocmV2aXNpb24gMTQyNDEpDQorKysgcHNtb3VzZS1iYXNlLmMJKHdvcmtpbmcgY29weSkN
CkBAIC00MCw3ICs0MCwxMyBAQA0KIA0KIHN0YXRpYyBpbnQgcHNtb3VzZV9ub2V4dDsNCiBpbnQg
cHNtb3VzZV9yZXNvbHV0aW9uOw0KKw0KKyNpZmRlZiBDT05GSUdfTU9VU0VfUFMyX0ZPUkNFX1JB
VEUNCit1bnNpZ25lZCBpbnQgcHNtb3VzZV9yYXRlID0gNjA7DQorI2Vsc2UNCiB1bnNpZ25lZCBp
bnQgcHNtb3VzZV9yYXRlOw0KKyNlbmRpZg0KKw0KIGludCBwc21vdXNlX3NtYXJ0c2Nyb2xsID0g
UFNNT1VTRV9MT0dJVEVDSF9TTUFSVFNDUk9MTDsNCiB1bnNpZ25lZCBpbnQgcHNtb3VzZV9yZXNl
dGFmdGVyOw0KIA0KQEAgLTQ3MSwxNiArNDc3LDIzIEBADQogICogV2Ugc2V0IHRoZSBtb3VzZSBy
ZXBvcnQgcmF0ZS4NCiAgKi8NCiANCisjaWZkZWYgQ09ORklHX01PVVNFX1BTMl9GT1JDRV9SQVRF
DQorCXBzbW91c2Vfc2V0X3JhdGUocHNtb3VzZSk7DQorI2Vsc2UNCiAJaWYgKHBzbW91c2VfcmF0
ZSkNCiAJCXBzbW91c2Vfc2V0X3JhdGUocHNtb3VzZSk7DQorI2VuZGlmDQogDQogLyoNCiAgKiBX
ZSBhbHNvIHNldCB0aGUgcmVzb2x1dGlvbiBhbmQgc2NhbGluZy4NCiAgKi8NCiANCisjaWZkZWYg
Q09ORklHX01PVVNFX1BTMl9GT1JDRV9SQVRFDQorCSBwc21vdXNlX3NldF9yZXNvbHV0aW9uKHBz
bW91c2UpOw0KKyNlbHNlDQogCWlmIChwc21vdXNlX3Jlc29sdXRpb24pDQogCQlwc21vdXNlX3Nl
dF9yZXNvbHV0aW9uKHBzbW91c2UpOw0KLQ0KKyNlbmRpZg0KIAlwc21vdXNlX2NvbW1hbmQocHNt
b3VzZSwgIE5VTEwsIFBTTU9VU0VfQ01EX1NFVFNDQUxFMTEpOw0KIA0KIC8qDQpAQCAtNjU0LDE3
ICs2NjcsMjIgQEANCiAJcmV0dXJuIDE7DQogfQ0KIA0KKyNpZm5kZWYgQ09ORklHX01PVVNFX1BT
Ml9GT1JDRV9SQVRFDQogc3RhdGljIGludCBfX2luaXQgcHNtb3VzZV9yYXRlX3NldHVwKGNoYXIg
KnN0cikNCiB7DQogCWdldF9vcHRpb24oJnN0ciwgJnBzbW91c2VfcmF0ZSk7DQogCXJldHVybiAx
Ow0KIH0NCisjZW5kaWYNCiANCiBfX3NldHVwKCJwc21vdXNlX25vZXh0IiwgcHNtb3VzZV9ub2V4
dF9zZXR1cCk7DQogX19zZXR1cCgicHNtb3VzZV9yZXNvbHV0aW9uPSIsIHBzbW91c2VfcmVzb2x1
dGlvbl9zZXR1cCk7DQogX19zZXR1cCgicHNtb3VzZV9zbWFydHNjcm9sbD0iLCBwc21vdXNlX3Nt
YXJ0c2Nyb2xsX3NldHVwKTsNCiBfX3NldHVwKCJwc21vdXNlX3Jlc2V0YWZ0ZXI9IiwgcHNtb3Vz
ZV9yZXNldGFmdGVyX3NldHVwKTsNCisNCisjaWZuZGVmIENPTkZJR19NT1VTRV9QUzJfRk9SQ0Vf
UkFURQ0KIF9fc2V0dXAoInBzbW91c2VfcmF0ZT0iLCBwc21vdXNlX3JhdGVfc2V0dXApOw0KKyNl
bmRpZg0KIA0KICNlbmRpZg0KIA0K

--=-jHE22hNutbrLEL6rwEL3--

--=-HWh3NqC9JrKW5+Uv+Rv7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/nxyGRGk68b69cdURAnNsAJ9HBlgyUTkFMaVX9TPnmTgKmrA9UwCfZhMQ
D8u9tfTn4fsv/wjmcMCAIoU=
=Eil2
-----END PGP SIGNATURE-----

--=-HWh3NqC9JrKW5+Uv+Rv7--

