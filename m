Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbRGRB10>; Tue, 17 Jul 2001 21:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbRGRB1Q>; Tue, 17 Jul 2001 21:27:16 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:10902 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S267388AbRGRB1J>; Tue, 17 Jul 2001 21:27:09 -0400
Date: Wed, 18 Jul 2001 02:27:12 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2.20-pre7 tiny NTFS fix
Message-ID: <Pine.SOL.3.96.1010718022151.2496A-200000@draco.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-995419632=:2496"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-995419632=:2496
Content-Type: TEXT/PLAIN; charset=US-ASCII

Alan,

Please apply attached patch for the next 2.2.20-pre release. It contains
a tiny ntfs fix to detect when the cluster size is too big and refuse to
mount the volume. (Without this patch the kernel panics which is not a
Good Thing and someone got anoyed enough with it to ask me to please fix
it...)

Patch is untested but considering it's a straight copy from 2.4 and it
passes a quick sanity check it should be fine.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

---559023410-851401618-995419632=:2496
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ntfs-2.2.20-pre7.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1010718022712.2496B@draco.cus.cam.ac.uk>
Content-Description: 

ZGlmZiAtdXJOIGxpbnV4LTIuMi4yMC1wcmU3LXZhbmlsbGEvZnMvbnRmcy9m
cy5jIGxpbnV4LTIuMi4yMC1wcmU3LW50ZnMvZnMvbnRmcy9mcy5jDQotLS0g
bGludXgtMi4yLjIwLXByZTctdmFuaWxsYS9mcy9udGZzL2ZzLmMJU3VuIE1h
ciAyNSAxNzozMTowMiAyMDAxDQorKysgbGludXgtMi4yLjIwLXByZTctbnRm
cy9mcy9udGZzL2ZzLmMJV2VkIEp1bCAxOCAwMjoxODo0NCAyMDAxDQpAQCAt
MjksNiArMjksNyBAQA0KICNpbmNsdWRlIDxsaW51eC9ubHMuaD4NCiAjaW5j
bHVkZSA8bGludXgvbG9ja3MuaD4NCiAjaW5jbHVkZSA8bGludXgvaW5pdC5o
Pg0KKyNpbmNsdWRlIDxhc20vcGFnZS5oPg0KIA0KIC8qIEZvcndhcmQgZGVj
bGFyYXRpb25zICovDQogc3RhdGljIHN0cnVjdCBpbm9kZV9vcGVyYXRpb25z
IG50ZnNfZGlyX2lub2RlX29wZXJhdGlvbnM7DQpAQCAtOTQxLDYgKzk0Miwx
MyBAQA0KIAlicmVsc2UoYmgpOw0KIAlOVEZTX1NCKHZvbCk9c2I7DQogCW50
ZnNfZGVidWcoREVCVUdfT1RIRVIsICJEb25lIHRvIGluaXQgdm9sdW1lXG4i
KTsNCisNCisJLyogQ2hlY2sgdGhlIGNsdXN0ZXIgc2l6ZSBpcyB3aXRoaW4g
YWxsb3dlZCBibG9ja3NpemUgbGltaXRzLiAqLw0KKwlpZiAodm9sLT5jbHVz
dGVyc2l6ZSA+IFBBR0VfU0laRSkgew0KKwkJbnRmc19lcnJvcigiUGFydGl0
aW9uIGNsdXN0ZXIgc2l6ZSBpcyBub3Qgc3VwcG9ydGVkIHlldCAoaXQgIg0K
KwkJCSAgICJpcyA+IG1heCBrZXJuZWwgYmxvY2tzaXplKS5cbiIpOw0KKwkJ
Z290byBudGZzX3JlYWRfc3VwZXJfdW5sOw0KKwl9DQogDQogCS8qIEluZm9y
bSB0aGUga2VybmVsIHRoYXQgYSBkZXZpY2UgYmxvY2sgaXMgYSBOVEZTIGNs
dXN0ZXIgKi8NCiAJc2ItPnNfYmxvY2tzaXplPXZvbC0+Y2x1c3RlcnNpemU7
DQo=
---559023410-851401618-995419632=:2496--
