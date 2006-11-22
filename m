Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756548AbWKVTAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756548AbWKVTAN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 14:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756512AbWKVTAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 14:00:13 -0500
Received: from bay0-omc3-s32.bay0.hotmail.com ([65.54.246.232]:60922 "EHLO
	bay0-omc3-s32.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756548AbWKVTAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 14:00:11 -0500
Message-ID: <BAY20-F249DFEB9C67DC4ECE4CA7ED8E30@phx.gbl>
X-Originating-IP: [80.178.108.101]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, wolfgang@iksw-muees.de
Subject: [PATCH 2.6.19-rc6] USB AUERSWALD: replace kmalloc+memset with kzalloc
Date: Wed, 22 Nov 2006 21:00:08 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_2617_44a7_698c"
X-OriginalArrivalTime: 22 Nov 2006 19:00:11.0648 (UTC) FILETIME=[6FAF1000:01C70E68]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_2617_44a7_698c
Content-Type: text/plain; format=flowed

Hi.

This patch replaces kmalloc+memset with kzalloc in USB AUERSWALD driver.

Regards
Yan Burman

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar - get it now! 
http://toolbar.msn.click-url.com/go/onm00200415ave/direct/01/

------=_NextPart_000_2617_44a7_698c
Content-Type: application/octet-stream; name="kzalloc_usb_auerswald.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kzalloc_usb_auerswald.patch"

UmVwbGFjZSBrbWFsbG9jK21lbXNldCB3aXRoIGt6YWxsb2MKClNpZ25lZC1v
ZmYtYnk6IFlhbiBCdXJtYW4gPHlhbl85NTJAaG90bWFpbC5jb20+CgpkaWZm
IC1ydWJwIGxpbnV4LTIuNi4xOS1yYzVfb3JpZy9kcml2ZXJzL3VzYi9taXNj
L2F1ZXJzd2FsZC5jIGxpbnV4LTIuNi4xOS1yYzVfa3phbGxvYy9kcml2ZXJz
L3VzYi9taXNjL2F1ZXJzd2FsZC5jCi0tLSBsaW51eC0yLjYuMTktcmM1X29y
aWcvZHJpdmVycy91c2IvbWlzYy9hdWVyc3dhbGQuYwkyMDA2LTExLTA5IDEy
OjE2OjIxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42LjE5LXJjNV9r
emFsbG9jL2RyaXZlcnMvdXNiL21pc2MvYXVlcnN3YWxkLmMJMjAwNi0xMS0x
MSAyMjo0NDoxOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTEzNzksNyArMTM3OSw3
IEBAIHN0YXRpYyBpbnQgYXVlcmNoYXJfb3BlbiAoc3RydWN0IGlub2RlICoK
IAl9CiAKIAkvKiB3ZSBoYXZlIGFjY2VzcyB0byB0aGUgZGV2aWNlLiBOb3cg
bGV0cyBhbGxvY2F0ZSBtZW1vcnkgKi8KLQljY3AgPSAocGF1ZXJjaGFyX3Qp
IGttYWxsb2Moc2l6ZW9mKGF1ZXJjaGFyX3QpLCBHRlBfS0VSTkVMKTsKKwlj
Y3AgPSBremFsbG9jKHNpemVvZihhdWVyY2hhcl90KSwgR0ZQX0tFUk5FTCk7
CiAJaWYgKGNjcCA9PSBOVUxMKSB7CiAJCWVyciAoIm91dCBvZiBtZW1vcnki
KTsKIAkJcmV0ID0gLUVOT01FTTsKQEAgLTEzODcsNyArMTM4Nyw2IEBAIHN0
YXRpYyBpbnQgYXVlcmNoYXJfb3BlbiAoc3RydWN0IGlub2RlICoKIAl9CiAK
IAkvKiBJbml0aWFsaXplIGRldmljZSBkZXNjcmlwdG9yICovCi0JbWVtc2V0
KCBjY3AsIDAsIHNpemVvZihhdWVyY2hhcl90KSk7CiAJaW5pdF9NVVRFWCgg
JmNjcC0+bXV0ZXgpOwogCWluaXRfTVVURVgoICZjY3AtPnJlYWRtdXRleCk7
CiAgICAgICAgIGF1ZXJidWZfaW5pdCAoJmNjcC0+YnVmY3RsKTsKQEAgLTE5
MTUsMTQgKzE5MTQsMTMgQEAgc3RhdGljIGludCBhdWVyc3dhbGRfcHJvYmUg
KHN0cnVjdCB1c2JfaQogCQlyZXR1cm4gLUVOT0RFVjsKIAogCS8qIGFsbG9j
YXRlIG1lbW9yeSBmb3Igb3VyIGRldmljZSBhbmQgaW5pdGlhbGl6ZSBpdCAq
LwotCWNwID0ga21hbGxvYyAoc2l6ZW9mKGF1ZXJzd2FsZF90KSwgR0ZQX0tF
Uk5FTCk7CisJY3AgPSBremFsbG9jIChzaXplb2YoYXVlcnN3YWxkX3QpLCBH
RlBfS0VSTkVMKTsKIAlpZiAoY3AgPT0gTlVMTCkgewogCQllcnIgKCJvdXQg
b2YgbWVtb3J5Iik7CiAJCWdvdG8gcGZhaWw7CiAJfQogCiAJLyogSW5pdGlh
bGl6ZSBkZXZpY2UgZGVzY3JpcHRvciAqLwotCW1lbXNldCAoY3AsIDAsIHNp
emVvZihhdWVyc3dhbGRfdCkpOwogCWluaXRfTVVURVggKCZjcC0+bXV0ZXgp
OwogCWNwLT51c2JkZXYgPSB1c2JkZXY7CiAJYXVlcmNoYWluX2luaXQgKCZj
cC0+Y29udHJvbGNoYWluKTsK


------=_NextPart_000_2617_44a7_698c--
