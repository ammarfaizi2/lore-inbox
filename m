Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756411AbWKVSuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756411AbWKVSuB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756472AbWKVSuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:50:01 -0500
Received: from bay0-omc2-s16.bay0.hotmail.com ([65.54.246.152]:30250 "EHLO
	bay0-omc2-s16.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1756411AbWKVSuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:50:00 -0500
Message-ID: <BAY20-F2362B2DCA3C310D64DB2BD8E30@phx.gbl>
X-Originating-IP: [80.178.108.101]
X-Originating-Email: [yan_952@hotmail.com]
From: "Burman Yan" <yan_952@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: trivial@kernel.org, dbrownell@users.sourceforge.net
Subject: [PATCH 2.6.19-rc5] USB gadget: replace kmalloc+memset with kzalloc
Date: Wed, 22 Nov 2006 20:49:58 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_1aa7_3cdf_13aa"
X-OriginalArrivalTime: 22 Nov 2006 18:50:00.0361 (UTC) FILETIME=[03541190:01C70E67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_1aa7_3cdf_13aa
Content-Type: text/plain; format=flowed

Hi.

This trivial patch replaces kmalloc+memset with kzalloc in the usb gadget 
sources.

Regards
Yan Buman

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

------=_NextPart_000_1aa7_3cdf_13aa
Content-Type: application/octet-stream; name="kzalloc_usb_gadget.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="kzalloc_usb_gadget.patch"

UmVwbGFjZSBrbWFsbG9jK21lbXNldCB3aXRoIGt6YWxsb2MKClNpZ25lZC1v
ZmYtYnk6IFlhbiBCdXJtYW4gPHlhbl85NTJAaG90bWFpbC5jb20+CgpkaWZm
IC1ydWJwIGxpbnV4LTIuNi4xOS1yYzZfb3JpZy9kcml2ZXJzL3VzYi9nYWRn
ZXQvZ29rdV91ZGMuYyBsaW51eC0yLjYuMTktcmM2L2RyaXZlcnMvdXNiL2dh
ZGdldC9nb2t1X3VkYy5jCi0tLSBsaW51eC0yLjYuMTktcmM2X29yaWcvZHJp
dmVycy91c2IvZ2FkZ2V0L2dva3VfdWRjLmMJMjAwNi0xMS0yMiAyMDoyOToz
MS4wMDAwMDAwMDAgKzAyMDAKKysrIGxpbnV4LTIuNi4xOS1yYzYvZHJpdmVy
cy91c2IvZ2FkZ2V0L2dva3VfdWRjLmMJMjAwNi0xMS0yMiAyMDozMzoyMy4w
MDAwMDAwMDAgKzAyMDAKQEAgLTE4NjQsMTQgKzE4NjQsMTMgQEAgc3RhdGlj
IGludCBnb2t1X3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZAogCX0KIAogCS8q
IGFsbG9jLCBhbmQgc3RhcnQgaW5pdCAqLwotCWRldiA9IGttYWxsb2MgKHNp
emVvZiAqZGV2LCBTTEFCX0tFUk5FTCk7CisJZGV2ID0ga3phbGxvYyAoc2l6
ZW9mICpkZXYsIFNMQUJfS0VSTkVMKTsKIAlpZiAoZGV2ID09IE5VTEwpewog
CQlwcl9kZWJ1ZygiZW5vbWVtICVzXG4iLCBwY2lfbmFtZShwZGV2KSk7CiAJ
CXJldHZhbCA9IC1FTk9NRU07CiAJCWdvdG8gZG9uZTsKIAl9CiAKLQltZW1z
ZXQoZGV2LCAwLCBzaXplb2YgKmRldik7CiAJc3Bpbl9sb2NrX2luaXQoJmRl
di0+bG9jayk7CiAJZGV2LT5wZGV2ID0gcGRldjsKIAlkZXYtPmdhZGdldC5v
cHMgPSAmZ29rdV9vcHM7CmRpZmYgLXJ1YnAgbGludXgtMi42LjE5LXJjNl9v
cmlnL2RyaXZlcnMvdXNiL2dhZGdldC9zZXJpYWwuYyBsaW51eC0yLjYuMTkt
cmM2L2RyaXZlcnMvdXNiL2dhZGdldC9zZXJpYWwuYwotLS0gbGludXgtMi42
LjE5LXJjNl9vcmlnL2RyaXZlcnMvdXNiL2dhZGdldC9zZXJpYWwuYwkyMDA2
LTExLTIyIDIwOjI5OjMxLjAwMDAwMDAwMCArMDIwMAorKysgbGludXgtMi42
LjE5LXJjNi9kcml2ZXJzL3VzYi9nYWRnZXQvc2VyaWFsLmMJMjAwNi0xMS0y
MiAyMDozMzoyMy4wMDAwMDAwMDAgKzAyMDAKQEAgLTE0MjksNyArMTQyOSw3
IEBAIHN0YXRpYyBpbnQgX19pbml0IGdzX2JpbmQoc3RydWN0IHVzYl9nYWQK
IAkJZ3NfYWNtX2NvbmZpZ19kZXNjLmJtQXR0cmlidXRlcyB8PSBVU0JfQ09O
RklHX0FUVF9XQUtFVVA7CiAJfQogCi0JZ3NfZGV2aWNlID0gZGV2ID0ga21h
bGxvYyhzaXplb2Yoc3RydWN0IGdzX2RldiksIEdGUF9LRVJORUwpOworCWdz
X2RldmljZSA9IGRldiA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBnc19kZXYp
LCBHRlBfS0VSTkVMKTsKIAlpZiAoZGV2ID09IE5VTEwpCiAJCXJldHVybiAt
RU5PTUVNOwogCkBAIC0xNDM3LDcgKzE0MzcsNiBAQCBzdGF0aWMgaW50IF9f
aW5pdCBnc19iaW5kKHN0cnVjdCB1c2JfZ2FkCiAJCWluaXRfdXRzbmFtZSgp
LT5zeXNuYW1lLCBpbml0X3V0c25hbWUoKS0+cmVsZWFzZSwKIAkJZ2FkZ2V0
LT5uYW1lKTsKIAotCW1lbXNldChkZXYsIDAsIHNpemVvZihzdHJ1Y3QgZ3Nf
ZGV2KSk7CiAJZGV2LT5kZXZfZ2FkZ2V0ID0gZ2FkZ2V0OwogCXNwaW5fbG9j
a19pbml0KCZkZXYtPmRldl9sb2NrKTsKIAlJTklUX0xJU1RfSEVBRCgmZGV2
LT5kZXZfcmVxX2xpc3QpOwo=


------=_NextPart_000_1aa7_3cdf_13aa--
