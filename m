Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262794AbTI2DIv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 23:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTI2DIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 23:08:51 -0400
Received: from viriato1.servicios.retecal.es ([212.89.0.44]:57553 "EHLO
	viriato1.servicios.retecal.es") by vger.kernel.org with ESMTP
	id S262794AbTI2DIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 23:08:48 -0400
Subject: [patch][2.6.0-test6] ALSA pci Kconfig polishes
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3b65fb2M6XrtuJgp+C0K"
Organization: Hispalinux - http://www.hispalinux.es
Message-Id: <1064804924.11516.3.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Sep 2003 05:08:45 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3b65fb2M6XrtuJgp+C0K
Content-Type: multipart/mixed; boundary="=-6tza3MgjQJ6YvshUjntF"


--=-6tza3MgjQJ6YvshUjntF
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi.

I think the ALSA pci devices must select the GAMEPORT option
automatically instead of depends on GAMEPORT.

The GAMEPORT is a feature of the device, is not a requisite.
--=20
Ram=F3n Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
GPG public key ID 	0xBEBD71D5 -> http://pgp.escomposlinux.org/



--=-6tza3MgjQJ6YvshUjntF
Content-Disposition: inline; filename=alsa_pci_select_gameport.diff
Content-Type: text/x-patch; name=alsa_pci_select_gameport.diff; charset=ISO-8859-15
Content-Transfer-Encoding: base64

SW5kZXg6IHNvdW5kL3BjaS9LY29uZmlnDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gc291bmQvcGNpL0tjb25m
aWcJKHJldmlzaW9uIDEzNjE5KQ0KKysrIHNvdW5kL3BjaS9LY29uZmlnCSh3b3JraW5nIGNvcHkp
DQpAQCAtMTcsNyArMTcsOCBAQA0KIA0KIGNvbmZpZyBTTkRfQ1M0NlhYDQogCXRyaXN0YXRlICJD
aXJydXMgTG9naWMgKFNvdW5kIEZ1c2lvbikgQ1M0MjgwL0NTNDYxeC9DUzQ2MngvQ1M0NjN4Ig0K
LQlkZXBlbmRzIG9uIFNORCAmJiBHQU1FUE9SVA0KKwlkZXBlbmRzIG9uIFNORA0KKwlzZWxlY3Qg
R0FNRVBPUlQNCiAJaGVscA0KIAkgIFNheSAnWScgb3IgJ00nIHRvIGluY2x1ZGUgc3VwcG9ydCBm
b3IgQ2lycnVzIExvZ2ljIENTNDYxMCAvIENTNDYxMiAvDQogCSAgQ1M0NjE0IC8gQ1M0NjE1IC8g
Q1M0NjIyIC8gQ1M0NjI0IC8gQ1M0NjMwIC8gQ1M0MjgwIGNoaXBzLg0KQEAgLTMwLDcgKzMxLDgg
QEANCiANCiBjb25maWcgU05EX0NTNDI4MQ0KIAl0cmlzdGF0ZSAiQ2lycnVzIExvZ2ljIChTb3Vu
ZCBGdXNpb24pIENTNDI4MSINCi0JZGVwZW5kcyBvbiBTTkQgJiYgR0FNRVBPUlQNCisJZGVwZW5k
cyBvbiBTTkQNCisJc2VsZWN0IEdBTUVQT1JUDQogCWhlbHANCiAJICBTYXkgJ1knIG9yICdNJyB0
byBpbmNsdWRlIHN1cHBvcnQgZm9yIENpcnJ1cyBMb2dpYyBDUzQyODEuDQogDQpAQCAtODMsNyAr
ODUsOCBAQA0KIA0KIGNvbmZpZyBTTkRfVFJJREVOVA0KIAl0cmlzdGF0ZSAiVHJpZGVudCA0RC1X
YXZlIERYL05YOyBTaVMgNzAxOCINCi0JZGVwZW5kcyBvbiBTTkQgJiYgR0FNRVBPUlQNCisJZGVw
ZW5kcyBvbiBTTkQNCisJc2VsZWN0IEdBTUVQT1JUDQogCWhlbHANCiAJICBTYXkgJ1knIG9yICdN
JyB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIFRyaWRlbnQgNEQtV2F2ZSBEWC9OWCBhbmQNCiAJICBT
aVMgNzAxOCBzb3VuZGNhcmRzLg0KQEAgLTExMCwyMCArMTEzLDIzIEBADQogDQogY29uZmlnIFNO
RF9FTlMxMzcwDQogCXRyaXN0YXRlICIoQ3JlYXRpdmUpIEVuc29uaXEgQXVkaW9QQ0kgMTM3MCIN
Ci0JZGVwZW5kcyBvbiBTTkQgJiYgR0FNRVBPUlQNCisJZGVwZW5kcyBvbiBTTkQNCisJc2VsZWN0
IEdBTUVQT1JUDQogCWhlbHANCiAJICBTYXkgJ1knIG9yICdNJyB0byBpbmNsdWRlIHN1cHBvcnQg
Zm9yIEVuc29uaXEgQXVkaW9QQ0kgRVMxMzcwLg0KIA0KIGNvbmZpZyBTTkRfRU5TMTM3MQ0KIAl0
cmlzdGF0ZSAiKENyZWF0aXZlKSBFbnNvbmlxIEF1ZGlvUENJIDEzNzEvMTM3MyINCi0JZGVwZW5k
cyBvbiBTTkQgJiYgR0FNRVBPUlQNCisJZGVwZW5kcyBvbiBTTkQNCisJc2VsZWN0IEdBTUVQT1JU
DQogCWhlbHANCiAJICBTYXkgJ1knIG9yICdNJyB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIEVuc29u
aXEgQXVkaW9QQ0kgRVMxMzcxIGFuZA0KIAkgIFNvdW5kIEJsYXN0ZXIgUENJIDY0IG9yIDEyOCBz
b3VuZGNhcmRzLg0KIA0KIGNvbmZpZyBTTkRfRVMxOTM4DQogCXRyaXN0YXRlICJFU1MgRVMxOTM4
LzE5NDYvMTk2OSAoU29sby0xKSINCi0JZGVwZW5kcyBvbiBTTkQgJiYgR0FNRVBPUlQNCisJZGVw
ZW5kcyBvbiBTTkQNCisJc2VsZWN0IEdBTUVQT1JUDQogCWhlbHANCiAJICBTYXkgJ1knIG9yICdN
JyB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIEVTUyBTb2xvLTEgKEVTMTkzOCwgRVMxOTQ2LCBFUzE5
NjkpDQogCSAgc291bmRjYXJkLg0KQEAgLTE3Myw3ICsxNzksOCBAQA0KIA0KIGNvbmZpZyBTTkRf
U09OSUNWSUJFUw0KIAl0cmlzdGF0ZSAiUzMgU29uaWNWaWJlcyINCi0JZGVwZW5kcyBvbiBTTkQg
JiYgR0FNRVBPUlQNCisJZGVwZW5kcyBvbiBTTkQNCisJc2VsZWN0IEdBTUVQT1JUDQogCWhlbHAN
CiAJICBTYXkgJ1knIG9yICdNJyB0byBpbmNsdWRlIHN1cHBvcnQgZm9yIFMzIFNvbmljVmliZXMg
YmFzZWQgc291bmRjYXJkcy4NCiANCg==

--=-6tza3MgjQJ6YvshUjntF--

--=-3b65fb2M6XrtuJgp+C0K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/d6I7RGk68b69cdURAt7lAJ9G9xePigLOrPfPsDc7v5uOZCPx3wCfe4zd
sWofhRPHLLhJUW/9NOIMQTE=
=Qs4w
-----END PGP SIGNATURE-----

--=-3b65fb2M6XrtuJgp+C0K--

