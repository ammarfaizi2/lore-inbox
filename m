Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbUJ0Jip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbUJ0Jip (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbUJ0Jio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:38:44 -0400
Received: from fep03fe.ttnet.net.tr ([212.156.4.134]:52478 "EHLO
	fep03.ttnet.net.tr") by vger.kernel.org with ESMTP id S262348AbUJ0Jfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:35:34 -0400
X-Mailer: Openwave WebEngine, version 2.8.11 (webedge20-101-194-20030622)
From: <sezeroz@ttnet.net.tr>
To: <linux-kernel@vger.kernel.org>
CC: <marcelo.tosatti@cyclades.com>
Subject: 2.4.28-rc1, more lost patches [3/10]
Date: Wed, 27 Oct 2004 12:33:52 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=____1098869632671_DpTU-mCPpR"
Message-Id: <20041027093352.JYEB6935.fep01.ttnet.net.tr@localhost>
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=____1098869632671_DpTU-mCPpR
Content-Type: text/plain;
	charset=ISO-8859-9
Content-Transfer-Encoding: 7bit


[3/10] binfmt_elf memleak, missing parts of Oleg's patch. in 2.6.


------=____1098869632671_DpTU-mCPpR
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream;
	name="binfmt_elf-memleak.patch"
Content-Disposition: inline;
	filename="binfmt_elf-memleak.patch"

T2xlZyBEcm9raW4sIG1pc3NpbmcgcGFydHMgZnJvbSB0aGUgcGF0Y2ggcG9zdGVkIGF0Cmh0dHA6
Ly9tYXJjLnRoZWFpbXNncm91cC5jb20vP2w9bGludXgta2VybmVsJm09MTA1MTAzOTM0NjMxNjA5
Jnc9MgoKYWxyZWFkeSBpbiAyLjYKCmRpZmYgLXVyTiAyN3AyL2ZzL2JpbmZtdF9lbGYuYyAyN3Ay
LnBhYy9mcy9iaW5mbXRfZWxmLmMKLS0tIDI3cDIvZnMvYmluZm10X2VsZi5jCTIwMDQtMDQtMTQg
MTY6MDU6NDAuMDAwMDAwMDAwICswMzAwCisrKyAyN3AyLnBhYy9mcy9iaW5mbXRfZWxmLmMJMjAw
NC0wNS0wOSAyMzo1ODoxMC4wMDAwMDAwMDAgKzAzMDAKQEAgLTM3NSw3ICszNzUsNiBAQAogCXVu
c2lnbmVkIGxvbmcgdGV4dF9kYXRhLCBlbGZfZW50cnkgPSB+MFVMOwogCWNoYXIgKiBhZGRyOwog
CWxvZmZfdCBvZmZzZXQ7Ci0JaW50IHJldHZhbDsKIAogCWN1cnJlbnQtPm1tLT5lbmRfY29kZSA9
IGludGVycF9leC0+YV90ZXh0OwogCXRleHRfZGF0YSA9IGludGVycF9leC0+YV90ZXh0ICsgaW50
ZXJwX2V4LT5hX2RhdGE7CkBAIC0zOTcsMTEgKzM5Niw5IEBACiAJfQogCiAJZG9fYnJrKDAsIHRl
eHRfZGF0YSk7Ci0JcmV0dmFsID0gLUVOT0VYRUM7CiAJaWYgKCFpbnRlcnByZXRlci0+Zl9vcCB8
fCAhaW50ZXJwcmV0ZXItPmZfb3AtPnJlYWQpCiAJCWdvdG8gb3V0OwotCXJldHZhbCA9IGludGVy
cHJldGVyLT5mX29wLT5yZWFkKGludGVycHJldGVyLCBhZGRyLCB0ZXh0X2RhdGEsICZvZmZzZXQp
OwotCWlmIChyZXR2YWwgPCAwKQorCWlmIChpbnRlcnByZXRlci0+Zl9vcC0+cmVhZChpbnRlcnBy
ZXRlciwgYWRkciwgdGV4dF9kYXRhLCAmb2Zmc2V0KSA8IDApCiAJCWdvdG8gb3V0OwogCWZsdXNo
X2ljYWNoZV9yYW5nZSgodW5zaWduZWQgbG9uZylhZGRyLAogCSAgICAgICAgICAgICAgICAgICAo
dW5zaWduZWQgbG9uZylhZGRyICsgdGV4dF9kYXRhKTsK

------=____1098869632671_DpTU-mCPpR--
