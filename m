Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030188AbWJCPYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030188AbWJCPYR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 11:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030191AbWJCPYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 11:24:17 -0400
Received: from mout0.freenet.de ([194.97.50.131]:5509 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S1030188AbWJCPYQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 11:24:16 -0400
Date: Tue, 03 Oct 2006 17:25:07 +0200
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/11] 2.6.18-mm3 pktcdvd: new pkt_find_dev()
Reply-To: balagi@justmail.de
From: "Thomas Maier" <balagi@justmail.de>
Cc: "petero2@telia.com" <petero2@telia.com>, "akpm@osdl.org" <akpm@osdl.org>
Content-Type: multipart/mixed; boundary=----------KEhPz4eQfxjjJHT3ROXWKj
MIME-Version: 1.0
Message-ID: <op.tguo6ngciudtyh@master>
User-Agent: Opera Mail/9.00 (Win32)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------------KEhPz4eQfxjjJHT3ROXWKj
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

Hello,

this patch adds a pkt_find_dev() function for reusability and
groups all pkt_find*() functions.
Also pkt_remove_dev() can use now the device id of the mapped
block device to remove the mapping.

http://people.freenet.de/BalaGi/download/pktcdvd-3-util-pkt_find_dev_2.6.18.patch

Note: patch 1/11 and 2/11 of this patch set were applied to 2.6.18-mm2 and
therefore are already in 2.6.18-mm3:
http://people.freenet.de/BalaGi/download/pktcdvd-2-pktdev_major_2.6.18.patch
http://people.freenet.de/BalaGi/download/pktcdvd-1-macro-driver-name_2.6.18.patch


Signed-off-by: Thomas Maier<balagi@justmail.de>

-Thomas Maier
------------KEhPz4eQfxjjJHT3ROXWKj
Content-Disposition: attachment; filename=pktcdvd-3-util-pkt_find_dev_2.6.18.patch
Content-Type: application/octet-stream; name=pktcdvd-3-util-pkt_find_dev_2.6.18.patch
Content-Transfer-Encoding: Base64

ZGlmZiAtdXJwTiAyLXBrdGRldl9tYWpvci9kcml2ZXJzL2Jsb2NrL3BrdGNkdmQu
YyAzLXV0aWwtcGt0X2ZpbmRfZGV2L2RyaXZlcnMvYmxvY2svcGt0Y2R2ZC5jCi0t
LSAyLXBrdGRldl9tYWpvci9kcml2ZXJzL2Jsb2NrL3BrdGNkdmQuYwkyMDA2LTEw
LTAzIDExOjQ0OjUwLjAwMDAwMDAwMCArMDIwMAorKysgMy11dGlsLXBrdF9maW5k
X2Rldi9kcml2ZXJzL2Jsb2NrL3BrdGNkdmQuYwkyMDA2LTEwLTAzIDExOjQ1OjE3
LjAwMDAwMDAwMCArMDIwMApAQCAtODcsNiArODcsNDEgQEAgc3RhdGljIHN0cnVj
dCBtdXRleCBjdGxfbXV0ZXg7CS8qIFNlcmlhbAogc3RhdGljIG1lbXBvb2xfdCAq
cHNkX3Bvb2w7CiAKIAorLyoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorICogdXRpbHMKKyAq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKi8KKworc3RhdGljIHN0cnVjdCBwa3RjZHZkX2Rldmlj
ZSAqcGt0X2ZpbmRfZGV2X2Zyb21fbWlub3IoaW50IGRldl9taW5vcikKK3sKKwlp
ZiAoZGV2X21pbm9yID49IE1BWF9XUklURVJTKQorCQlyZXR1cm4gTlVMTDsKKwly
ZXR1cm4gcGt0X2RldnNbZGV2X21pbm9yXTsKK30KKworLyoKKyAqIGZpbmQgYSBw
a3RjZHZkX2RldmljZSBieSBpdCdzIGRldmljZSBpZCBhbmQgcmV0dXJuIHRoZSBp
bmRleAorICogaW4gdGhlIHBrdF9kZXZzIGFycmF5IGluICpwaWR4LiBpZiBpc21i
ZCAhPSAwLCBhc3N1bWUgdGhhdAorICogZGV2aWQgaXMgdGhlIGRldmljZSBpZCBv
ZiB0aGUgbWFwcGVkIGJsb2NrIGRldmljZS4KKyAqLworc3RhdGljIHN0cnVjdCBw
a3RjZHZkX2RldmljZSAqcGt0X2ZpbmRfZGV2KGRldl90IGRldmlkLCBpbnQgaXNt
YmQsIGludCogcGlkeCkKK3sKKwlpbnQgaWR4OworCWZvciAoaWR4ID0gMDsgaWR4
IDwgTUFYX1dSSVRFUlM7IGlkeCsrKSB7CisJCXN0cnVjdCBwa3RjZHZkX2Rldmlj
ZSAqcGQgPSBwa3RfZGV2c1tpZHhdOworCQlpZiAocGQgJiYgKCghaXNtYmQgJiYg
cGQtPnBrdF9kZXYgPT0gZGV2aWQpCisJCQl8fCAoaXNtYmQgJiYgcGQtPmJkZXYg
JiYgcGQtPmJkZXYtPmJkX2RldiA9PSBkZXZpZCkpKSB7CisJCQlpZiAocGlkeCkK
KwkJCQkqcGlkeCA9IGlkeDsKKwkJCXJldHVybiBwZDsKKwkJfQorCX0KKwlpZiAo
cGlkeCkKKwkJKnBpZHggPSAwOworCXJldHVybiBOVUxMOworfQorCisvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKiovCisKIHN0YXRpYyB2b2lkIHBrdF9iaW9fZmluaXNoZWQoc3Ry
dWN0IHBrdGNkdmRfZGV2aWNlICpwZCkKIHsKIAlCVUdfT04oYXRvbWljX3JlYWQo
JnBkLT5jZHJ3LnBlbmRpbmdfYmlvcykgPD0gMCk7CkBAIC0xOTk2LDEzICsyMDMx
LDYgQEAgc3RhdGljIHZvaWQgcGt0X3JlbGVhc2VfZGV2KHN0cnVjdCBwa3RjZAog
CXBrdF9zaHJpbmtfcGt0bGlzdChwZCk7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgcGt0
Y2R2ZF9kZXZpY2UgKnBrdF9maW5kX2Rldl9mcm9tX21pbm9yKGludCBkZXZfbWlu
b3IpCi17Ci0JaWYgKGRldl9taW5vciA+PSBNQVhfV1JJVEVSUykKLQkJcmV0dXJu
IE5VTEw7Ci0JcmV0dXJuIHBrdF9kZXZzW2Rldl9taW5vcl07Ci19Ci0KIHN0YXRp
YyBpbnQgcGt0X29wZW4oc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUg
KmZpbGUpCiB7CiAJc3RydWN0IHBrdGNkdmRfZGV2aWNlICpwZCA9IE5VTEw7CkBA
IC0yNTE2LDE0ICsyNTQ0LDE0IEBAIHN0YXRpYyBpbnQgcGt0X3JlbW92ZV9kZXYo
c3RydWN0IHBrdF9jdHIKIAlpbnQgaWR4OwogCWRldl90IHBrdF9kZXYgPSBuZXdf
ZGVjb2RlX2RldihjdHJsX2NtZC0+cGt0X2Rldik7CiAKLQlmb3IgKGlkeCA9IDA7
IGlkeCA8IE1BWF9XUklURVJTOyBpZHgrKykgewotCQlwZCA9IHBrdF9kZXZzW2lk
eF07Ci0JCWlmIChwZCAmJiAocGQtPnBrdF9kZXYgPT0gcGt0X2RldikpCi0JCQli
cmVhazsKLQl9Ci0JaWYgKGlkeCA9PSBNQVhfV1JJVEVSUykgewotCQlEUFJJTlRL
KERSSVZFUl9OQU1FIjogZGV2IG5vdCBzZXR1cFxuIik7Ci0JCXJldHVybiAtRU5Y
SU87CisJcGQgPSBwa3RfZmluZF9kZXYocGt0X2RldiwgMCwgJmlkeCk7CisJaWYg
KCFwZCkgeworCQkvKiBtYXliZSBwa3RfZGV2IGlzIHRoZSBtYXBwZWQgYmxvY2sg
ZGV2aWNlIGlkICovCisJCXBkID0gcGt0X2ZpbmRfZGV2KHBrdF9kZXYsIDEsICZp
ZHgpOworCQlpZiAoIXBkKSB7CisJCQlEUFJJTlRLKERSSVZFUl9OQU1FIjogZGV2
IG5vdCBzZXR1cFxuIik7CisJCQlyZXR1cm4gLUVOWElPOworCQl9CiAJfQogCiAJ
aWYgKHBkLT5yZWZjbnQgPiAwKQo=

------------KEhPz4eQfxjjJHT3ROXWKj--

