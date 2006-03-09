Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWCIWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWCIWOE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 17:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbWCIWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 17:14:04 -0500
Received: from mga02.intel.com ([134.134.136.20]:48761 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751937AbWCIWOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 17:14:02 -0500
X-IronPort-AV: i="4.02,179,1139212800"; 
   d="scan'208"; a="12294896:sNHT51609460"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C643C6.C36B05B8"
Subject: RE: [Mactel-linux-devel] Re: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
Date: Thu, 9 Mar 2006 14:13:57 -0800
Message-ID: <D36CE1FCEFD3524B81CA12C6FE5BCAB00CA2309B@fmsmsx406.amr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [Mactel-linux-devel] Re: [PATCH] /sys/firmware/efi/systab giving incorrect value for smbios
thread-index: AcY/vvVjQTW4X/VzSfioQe3cqF/aAwEB47DA
From: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
To: "gimli" <gimli@dark-green.com>, "Matthew Garrett" <mjg59@srcf.ucam.org>
Cc: <mactel-linux-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Mar 2006 22:13:59.0252 (UTC) FILETIME=[C3B32140:01C643C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C643C6.C36B05B8
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

gimli <> wrote:
> Hi.
>=20
> Do you have any idea why the kernel crashes on machines with more
> then 512 MB ram ?=20
>=20

Can you try the latest -mm with the attached patch on your machine?  =20
This should fix it. =20

matt

------_=_NextPart_001_01C643C6.C36B05B8
Content-Type: application/octet-stream;
	name="efi-fixes.patch"
Content-Transfer-Encoding: base64
Content-Description: efi-fixes.patch
Content-Disposition: attachment;
	filename="efi-fixes.patch"

ZGlmZiAtdXJOcCBsaW51eC0yLjYuMTYtcmM1L2FyY2gvaTM4Ni9rZXJuZWwvZG1pX3NjYW4uYyBs
aW51eC0yLjYuMTYtcmM1LWVmaS9hcmNoL2kzODYva2VybmVsL2RtaV9zY2FuLmMKLS0tIGxpbnV4
LTIuNi4xNi1yYzUvYXJjaC9pMzg2L2tlcm5lbC9kbWlfc2Nhbi5jCTIwMDYtMDMtMTAgMDc6MDI6
MzguMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTYtcmM1LWVmaS9hcmNoL2kzODYva2Vy
bmVsL2RtaV9zY2FuLmMJMjAwNi0wMy0xMCAwNzowNTowNC4wMDAwMDAwMDAgLTA1MDAKQEAgLTIy
MywxMiArMjIzLDExIEBAIHZvaWQgX19pbml0IGRtaV9zY2FuX21hY2hpbmUodm9pZCkKICAgICAg
ICAgICAgICAgICAqIG5lZWRlZCBkdXJpbmcgZWFybHkgYm9vdC4gIFRoaXMgYWxzbyBtZWFucyB3
ZSBjYW4KICAgICAgICAgICAgICAgICAqIGlvdW5tYXAgdGhlIHNwYWNlIHdoZW4gd2UncmUgZG9u
ZSB3aXRoIGl0LgogCQkqLwotCQlwID0gaW9yZW1hcChlZmkuc21iaW9zLCAzMik7CisJCXAgPSBk
bWlfaW9yZW1hcChlZmkuc21iaW9zLCAzMik7CiAJCWlmIChwID09IE5VTEwpCiAJCQlnb3RvIG91
dDsKIAogCQlyYyA9IGRtaV9wcmVzZW50KHAgKyAweDEwKTsgLyogb2Zmc2V0IG9mIF9ETUlfIHN0
cmluZyAqLwotCQlpb3VubWFwKHApOwogCQlpZiAoIXJjKQogCQkJcmV0dXJuOwogCX0KZGlmZiAt
dXJOcCBsaW51eC0yLjYuMTYtcmM1L2FyY2gvaTM4Ni9rZXJuZWwvc2V0dXAuYyBsaW51eC0yLjYu
MTYtcmM1LWVmaS9hcmNoL2kzODYva2VybmVsL3NldHVwLmMKLS0tIGxpbnV4LTIuNi4xNi1yYzUv
YXJjaC9pMzg2L2tlcm5lbC9zZXR1cC5jCTIwMDYtMDMtMTAgMDc6MDI6MzguMDAwMDAwMDAwIC0w
NTAwCisrKyBsaW51eC0yLjYuMTYtcmM1LWVmaS9hcmNoL2kzODYva2VybmVsL3NldHVwLmMJMjAw
Ni0wMy0xMCAwNjo1NTo0OC4wMDAwMDAwMDAgLTA1MDAKQEAgLTEwNTAsMTAgKzEwNTAsMTAgQEAg
c3RhdGljIGludCBfX2luaXQKIGZyZWVfYXZhaWxhYmxlX21lbW9yeSh1bnNpZ25lZCBsb25nIHN0
YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCwgdm9pZCAqYXJnKQogewogCS8qIGNoZWNrIG1heF9sb3df
cGZuICovCi0JaWYgKHN0YXJ0ID49ICgobWF4X2xvd19wZm4gKyAxKSA8PCBQQUdFX1NISUZUKSkK
KwlpZiAoc3RhcnQgPj0gKG1heF9sb3dfcGZuIDw8IFBBR0VfU0hJRlQpKQogCQlyZXR1cm4gMDsK
LQlpZiAoZW5kID49ICgobWF4X2xvd19wZm4gKyAxKSA8PCBQQUdFX1NISUZUKSkKLQkJZW5kID0g
KG1heF9sb3dfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsKKwlpZiAoZW5kID49IChtYXhfbG93X3Bm
biA8PCBQQUdFX1NISUZUKSkKKwkJZW5kID0gbWF4X2xvd19wZm4gPDwgUEFHRV9TSElGVDsKIAlp
ZiAoc3RhcnQgPCBlbmQpCiAJCWZyZWVfYm9vdG1lbShzdGFydCwgZW5kIC0gc3RhcnQpOwogCmRp
ZmYgLXVyTnAgbGludXgtMi42LjE2LXJjNS9kcml2ZXJzL2FjcGkvdGFibGVzLmMgbGludXgtMi42
LjE2LXJjNS1lZmkvZHJpdmVycy9hY3BpL3RhYmxlcy5jCi0tLSBsaW51eC0yLjYuMTYtcmM1L2Ry
aXZlcnMvYWNwaS90YWJsZXMuYwkyMDA2LTAyLTI3IDAwOjA5OjM1LjAwMDAwMDAwMCAtMDUwMAor
KysgbGludXgtMi42LjE2LXJjNS1lZmkvZHJpdmVycy9hY3BpL3RhYmxlcy5jCTIwMDYtMDMtMTAg
MDQ6Mzc6MTguMDAwMDAwMDAwIC0wNTAwCkBAIC01ODcsNyArNTg3LDggQEAgaW50IF9faW5pdCBh
Y3BpX3RhYmxlX2luaXQodm9pZCkKIAkJcmV0dXJuIC1FTk9ERVY7CiAJfQogCi0JcnNkcCA9IChz
dHJ1Y3QgYWNwaV90YWJsZV9yc2RwICopX192YShyc2RwX3BoeXMpOworCXJzZHAgPSAoc3RydWN0
IGFjcGlfdGFibGVfcnNkcCAqKV9fYWNwaV9tYXBfdGFibGUocnNkcF9waHlzLCAKKwkJc2l6ZW9m
KHN0cnVjdCBhY3BpX3RhYmxlX3JzZHApKTsKIAlpZiAoIXJzZHApIHsKIAkJcHJpbnRrKEtFUk5f
V0FSTklORyBQUkVGSVggIlVuYWJsZSB0byBtYXAgUlNEUFxuIik7CiAJCXJldHVybiAtRU5PREVW
Owo=

------_=_NextPart_001_01C643C6.C36B05B8--
