Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUIUTvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUIUTvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 15:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268031AbUIUTvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 15:51:33 -0400
Received: from ns.donapex.net ([194.44.21.53]:39429 "EHLO ns.donapex.net")
	by vger.kernel.org with ESMTP id S268030AbUIUTv3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 15:51:29 -0400
Date: Tue, 21 Sep 2004 22:51:27 +0300
From: "Vitaly V. Bursov" <vitalyvb@ukr.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] drivers/input/serio/serport.c prevents usage of kfree()'ed
 memory
Message-Id: <20040921225127.2aa203b0.vitalyvb@ukr.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__21_Sep_2004_22_51_27_+0300_HWo/8K2d4MZzQ3Z="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__21_Sep_2004_22_51_27_+0300_HWo/8K2d4MZzQ3Z=
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__21_Sep_2004_22_51_27_+0300_+Kr3CBTwO3bQlfmI"


--Multipart=_Tue__21_Sep_2004_22_51_27_+0300_+Kr3CBTwO3bQlfmI
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hello,

This is a patch that hopefully fixes issues with serport module.

Please review.
-- 
Vitaly
GPG Key ID: F95A23B9

--Multipart=_Tue__21_Sep_2004_22_51_27_+0300_+Kr3CBTwO3bQlfmI
Content-Type: application/octet-stream;
 name="serport.c.patch"
Content-Disposition: attachment;
 filename="serport.c.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtdXJOIGEvZHJpdmVycy9pbnB1dC9zZXJpby9zZXJwb3J0LmMgYi9kcml2ZXJzL2lucHV0
L3NlcmlvL3NlcnBvcnQuYwotLS0gYS9kcml2ZXJzL2lucHV0L3NlcmlvL3NlcnBvcnQuYwkyMDA0
LTA5LTIxIDIyOjQzOjIyLjAwMDAwMDAwMCArMDMwMAorKysgYi9kcml2ZXJzL2lucHV0L3Nlcmlv
L3NlcnBvcnQuYwkyMDA0LTA5LTIxIDIyOjQ3OjU3LjU2ODI4NDAwMCArMDMwMApAQCAtMzMsNiAr
MzMsNyBAQAogCXdhaXRfcXVldWVfaGVhZF90IHdhaXQ7CiAJc3RydWN0IHNlcmlvICpzZXJpbzsK
IAl1bnNpZ25lZCBsb25nIGZsYWdzOworCWludCBxdWl0OwogfTsKIAogLyoKQEAgLTQ1LDExICs0
NiwxOSBAQAogCXJldHVybiAtKHNlcnBvcnQtPnR0eS0+ZHJpdmVyLT53cml0ZShzZXJwb3J0LT50
dHksIDAsICZkYXRhLCAxKSAhPSAxKTsKIH0KIAorc3RhdGljIGludCBzZXJwb3J0X3NlcmlvX29w
ZW4oc3RydWN0IHNlcmlvICpzZXJpbykgCit7IAorCXN0cnVjdCBzZXJwb3J0ICpzZXJwb3J0ID0g
c2VyaW8tPnBvcnRfZGF0YTsKKyAKKwlzZXJwb3J0LT5xdWl0ID0gMDsKKwlyZXR1cm4gMDsKK30g
CisKIHN0YXRpYyB2b2lkIHNlcnBvcnRfc2VyaW9fY2xvc2Uoc3RydWN0IHNlcmlvICpzZXJpbykK
IHsKIAlzdHJ1Y3Qgc2VycG9ydCAqc2VycG9ydCA9IHNlcmlvLT5wb3J0X2RhdGE7CiAKLQlzZXJw
b3J0LT5zZXJpby0+dHlwZSA9IDA7CisJc2VycG9ydC0+cXVpdCA9IDE7CiAJd2FrZV91cF9pbnRl
cnJ1cHRpYmxlKCZzZXJwb3J0LT53YWl0KTsKIH0KIApAQCAtODQsNiArOTMsNyBAQAogCXNlcmlv
LT50eXBlID0gU0VSSU9fUlMyMzI7CiAJc2VyaW8tPndyaXRlID0gc2VycG9ydF9zZXJpb193cml0
ZTsKIAlzZXJpby0+Y2xvc2UgPSBzZXJwb3J0X3NlcmlvX2Nsb3NlOworCXNlcmlvLT5vcGVuID0g
c2VycG9ydF9zZXJpb19vcGVuOwogCXNlcmlvLT5wb3J0X2RhdGEgPSBzZXJwb3J0OwogCiAJaW5p
dF93YWl0cXVldWVfaGVhZCgmc2VycG9ydC0+d2FpdCk7CkBAIC05OCw2ICsxMDgsMTMgQEAKIHN0
YXRpYyB2b2lkIHNlcnBvcnRfbGRpc2NfY2xvc2Uoc3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSkKIHsK
IAlzdHJ1Y3Qgc2VycG9ydCAqc2VycG9ydCA9IChzdHJ1Y3Qgc2VycG9ydCopIHR0eS0+ZGlzY19k
YXRhOworCisJc2VycG9ydC0+cXVpdCA9IDE7IAorCXdha2VfdXBfaW50ZXJydXB0aWJsZSgmc2Vy
cG9ydC0+d2FpdCk7IAorIAorCXdoaWxlICh0ZXN0X2JpdChTRVJQT1JUX0JVU1ksICZzZXJwb3J0
LT5mbGFncykpIAorCQlzY2hlZHVsZSgpOyAKKwogCWtmcmVlKHNlcnBvcnQpOwogfQogCkBAIC0x
NDAsMTIgKzE1NywxMiBAQAogCXN0cnVjdCBzZXJwb3J0ICpzZXJwb3J0ID0gKHN0cnVjdCBzZXJw
b3J0KikgdHR5LT5kaXNjX2RhdGE7CiAJY2hhciBuYW1lWzY0XTsKIAotCWlmICh0ZXN0X2FuZF9z
ZXRfYml0KFNFUlBPUlRfQlVTWSwgJnNlcnBvcnQtPmZsYWdzKSkKKwlpZiAoc2VycG9ydC0+cXVp
dCB8fCB0ZXN0X2FuZF9zZXRfYml0KFNFUlBPUlRfQlVTWSwgJnNlcnBvcnQtPmZsYWdzKSkKIAkJ
cmV0dXJuIC1FQlVTWTsKIAogCXNlcmlvX3JlZ2lzdGVyX3BvcnQoc2VycG9ydC0+c2VyaW8pOwog
CXByaW50ayhLRVJOX0lORk8gInNlcmlvOiBTZXJpYWwgcG9ydCAlc1xuIiwgdHR5X25hbWUodHR5
LCBuYW1lKSk7Ci0Jd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHNlcnBvcnQtPndhaXQsICFzZXJw
b3J0LT5zZXJpby0+dHlwZSk7CisJd2FpdF9ldmVudF9pbnRlcnJ1cHRpYmxlKHNlcnBvcnQtPndh
aXQsIHNlcnBvcnQtPnF1aXQpOwogCXNlcmlvX3VucmVnaXN0ZXJfcG9ydChzZXJwb3J0LT5zZXJp
byk7CiAKIAljbGVhcl9iaXQoU0VSUE9SVF9CVVNZLCAmc2VycG9ydC0+ZmxhZ3MpOwpAQCAtMTYx
LDYgKzE3OCw5IEBACiB7CiAJc3RydWN0IHNlcnBvcnQgKnNlcnBvcnQgPSAoc3RydWN0IHNlcnBv
cnQqKSB0dHktPmRpc2NfZGF0YTsKIAorCWlmICh0ZXN0X2JpdChTRVJQT1JUX0JVU1ksICZzZXJw
b3J0LT5mbGFncykgfHwgc2VycG9ydC0+cXVpdCkgCisJCXJldHVybiAtRUJVU1k7IAorCiAJaWYg
KGNtZCA9PSBTUElPQ1NUWVBFKQogCQlyZXR1cm4gZ2V0X3VzZXIoc2VycG9ydC0+c2VyaW8tPnR5
cGUsICh1bnNpZ25lZCBsb25nIF9fdXNlciAqKSBhcmcpOwogCg==

--Multipart=_Tue__21_Sep_2004_22_51_27_+0300_+Kr3CBTwO3bQlfmI--

--Signature=_Tue__21_Sep_2004_22_51_27_+0300_HWo/8K2d4MZzQ3Z=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBUIZF73PAj/laI7kRAsPnAJ9D9Hj/bc6mGaJYCouqBccul7lXxgCfSNlm
wL98o0sRqrX70ifVml1RQno=
=DjmB
-----END PGP SIGNATURE-----

--Signature=_Tue__21_Sep_2004_22_51_27_+0300_HWo/8K2d4MZzQ3Z=--
