Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262394AbUJ0KFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbUJ0KFY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUJ0KEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:04:53 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:13780 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262362AbUJ0Jxn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:53:43 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [1/10]
Date: Wed, 27 Oct 2004 12:51:45 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098870705760_?5QvAXz6Bl"
Message-Id: <20041027095145.KDRQ6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098870705760_?5QvAXz6Bl
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[10/10] Krzysztof Halasa: AF_UNIX dgram select problem;
from (only in) -ac/redhat. To be reviewed.


------=____1098870705760_?5QvAXz6Bl
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="af_unix-dgram_poll.patch"
Content-Disposition: inline;
	filename="af_unix-dgram_poll.patch"

S3J6eXN6dG9mIEhhbGFzYQpmaXJzdCBkaXNjdXNzaW9uL3RocmVhZDoKIGh0dHA6Ly9tYXJjLnRo
ZWFpbXNncm91cC5jb20vP3Q9MTA1NDY1MjQwOTAwMDA1JnI9MSZ3PTIKUGF0Y2ggdGhlbiBwb3N0
ZWQgYXQ6CiBodHRwOi8vbWFyYy50aGVhaW1zZ3JvdXAuY29tLz9sPWxpbnV4LWtlcm5lbCZtPTEw
NTU2MDQ3NTgxOTYxMCZ3PTIKCk5vIGZ1cnRoZXIgZGlzY3Vzc2lvbiBzZWVtcyB0byBhcHBlYXIg
dGhlcmVhZnRlci4KCm9ubHkgaW4gYWMvcmVkaGF0LCBfTk9UXyBpbiAyLjYKCmRpZmYgLXVyTiAy
OHJjMS9uZXQvdW5peC9hZl91bml4LmMgMjhyYzFfYWFjL25ldC91bml4L2FmX3VuaXguYwotLS0g
MjhyYzEvbmV0L3VuaXgvYWZfdW5peC5jCTIwMDItMTEtMjkgMDE6NTM6MTYuMDAwMDAwMDAwICsw
MjAwCisrKyAyOHJjMV9hYWMvbmV0L3VuaXgvYWZfdW5peC5jCTIwMDQtMTAtMjQgMDA6NTg6MTIu
MDAwMDAwMDAwICswMzAwCkBAIC0xNzA3LDYgKzE3MDcsMzkgQEAKIAlyZXR1cm4gZXJyOwogfQog
CitzdGF0aWMgdW5zaWduZWQgaW50IGRncmFtX3BvbGwoc3RydWN0IGZpbGUgKiBmaWxlLCBzdHJ1
Y3Qgc29ja2V0ICpzb2NrLAorCQkJICAgICAgIHBvbGxfdGFibGUgKndhaXQpCit7CisgICAgICAg
IHN0cnVjdCBzb2NrICpzayA9IHNvY2stPnNrOworICAgICAgICB1bnNpZ25lZCBpbnQgbWFzazsK
Kwl1bml4X3NvY2tldCAqb3RoZXI7CisKKyAgICAgICAgcG9sbF93YWl0KGZpbGUsIHNrLT5zbGVl
cCwgd2FpdCk7CisgICAgICAgIG1hc2sgPSAwOworCisgICAgICAgIC8qIGV4Y2VwdGlvbmFsIGV2
ZW50cz8gKi8KKyAgICAgICAgaWYgKHNrLT5lcnIgfHwgIXNrYl9xdWV1ZV9lbXB0eSgmc2stPmVy
cm9yX3F1ZXVlKSkKKyAgICAgICAgICAgICAgICBtYXNrIHw9IFBPTExFUlI7CisgICAgICAgIGlm
IChzay0+c2h1dGRvd24gPT0gU0hVVERPV05fTUFTSykKKyAgICAgICAgICAgICAgICBtYXNrIHw9
IFBPTExIVVA7CisKKyAgICAgICAgLyogcmVhZGFibGU/ICovCisgICAgICAgIGlmICghc2tiX3F1
ZXVlX2VtcHR5KCZzay0+cmVjZWl2ZV9xdWV1ZSkgfHwKKyAgICAgICAgICAgIChzay0+c2h1dGRv
d24gJiBSQ1ZfU0hVVERPV04pKQorICAgICAgICAgICAgICAgIG1hc2sgfD0gUE9MTElOIHwgUE9M
TFJETk9STTsKKworICAgICAgICAvKiB3cml0YWJsZT8gKi8KKwlvdGhlciA9IHVuaXhfcGVlcl9n
ZXQoc2spOworCWlmIChzb2NrX3dyaXRlYWJsZShzaykgJiYKKwkgICAgKG90aGVyID09IE5VTEwg
fHwKKwkgICAgIHNrYl9xdWV1ZV9sZW4oJm90aGVyLT5yZWNlaXZlX3F1ZXVlKSA8PSBvdGhlci0+
bWF4X2Fja19iYWNrbG9nKSkKKyAgICAgICAgICAgICAgICBtYXNrIHw9IFBPTExPVVQgfCBQT0xM
V1JOT1JNIHwgUE9MTFdSQkFORDsKKyAgICAgICAgZWxzZQorICAgICAgICAgICAgICAgIHNldF9i
aXQoU09DS19BU1lOQ19OT1NQQUNFLCAmc2stPnNvY2tldC0+ZmxhZ3MpOworCisJcmV0dXJuIG1h
c2s7Cit9CisKIHN0YXRpYyB1bnNpZ25lZCBpbnQgdW5peF9wb2xsKHN0cnVjdCBmaWxlICogZmls
ZSwgc3RydWN0IHNvY2tldCAqc29jaywgcG9sbF90YWJsZSAqd2FpdCkKIHsKIAlzdHJ1Y3Qgc29j
ayAqc2sgPSBzb2NrLT5zazsKQEAgLTE4MzYsNyArMTg2OSw3IEBACiAJc29ja2V0cGFpcjoJdW5p
eF9zb2NrZXRwYWlyLAogCWFjY2VwdDoJCXNvY2tfbm9fYWNjZXB0LAogCWdldG5hbWU6CXVuaXhf
Z2V0bmFtZSwKLQlwb2xsOgkJZGF0YWdyYW1fcG9sbCwKKwlwb2xsOgkJZGdyYW1fcG9sbCwKIAlp
b2N0bDoJCXVuaXhfaW9jdGwsCiAJbGlzdGVuOgkJc29ja19ub19saXN0ZW4sCiAJc2h1dGRvd246
CXVuaXhfc2h1dGRvd24sCg==

------=____1098870705760_?5QvAXz6Bl--
