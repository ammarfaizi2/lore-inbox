Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271894AbRHUXL4>; Tue, 21 Aug 2001 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271890AbRHUXLe>; Tue, 21 Aug 2001 19:11:34 -0400
Received: from ffke-campus-gw.mipt.ru ([194.85.82.65]:7145 "EHLO
	www.2ka.mipt.ru") by vger.kernel.org with ESMTP id <S271891AbRHUXLY>;
	Tue, 21 Aug 2001 19:11:24 -0400
Message-Id: <200108212311.f7LNBwl18820@www.2ka.mipt.ru>
Date: Wed, 22 Aug 2001 03:52:58 +0400
From: Evgeny Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: [very very small patch] that concerns ./fs/binfmt_elf.c and fix one of XXX
Reply-To: johnpol@2ka.mipt.ru
X-Mailer: stuphead ver. 0.5.3 (Wiskas) (GTK+ 1.2.7; Linux 2.4.9; i686)
Organization: MIPT
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__22_Aug_2001_03:52:58_+0400_081ee798"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__22_Aug_2001_03:52:58_+0400_081ee798
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Helo, linux guru.

This is a very small and first patch against 2.4.9 kernel.
I think anyone can do this, but forgot.
It was made after looking into binfmt_aaout.c and comparison with
binfmt_elf.c
And while the graetest guru are speaking about great, complex and
particularily needed tasks, small beginers are ( and i suppose lamers( and
i
hope not for a long time)) trying to fix small problems :))
Here it:

---
WBR. //s0mbre

--Multipart_Wed__22_Aug_2001_03:52:58_+0400_081ee798
Content-Type: text/plain;
 name="binfmt_elf.patch"
Content-Disposition: attachment;
 filename="binfmt_elf.patch"
Content-Transfer-Encoding: base64

LS0tIC90bXAvbGludXgvZnMvYmluZm10X2VsZi5jCVNhdCBKdWwgMjEgMjM6NDI6MjUgMjAwMQor
KysgLi9mcy9iaW5mbXRfZWxmLmMJV2VkIEF1ZyAyMiAwMTo0NDoyOCAyMDAxCkBAIC00MTMsNyAr
NDEzLDcgQEAKIAlzdHJ1Y3QgZWxmaGRyIGludGVycF9lbGZfZXg7CiAgIAlzdHJ1Y3QgZXhlYyBp
bnRlcnBfZXg7CiAJY2hhciBwYXNzZWRfZmlsZW5vWzZdOwotCisJCiAJLyogR2V0IHRoZSBleGVj
LWhlYWRlciAqLwogCWVsZl9leCA9ICooKHN0cnVjdCBlbGZoZHIgKikgYnBybS0+YnVmKTsKIApA
QCAtNTkyLDkgKzU5MiwxNCBAQAogCS8qIERvIHRoaXMgc28gdGhhdCB3ZSBjYW4gbG9hZCB0aGUg
aW50ZXJwcmV0ZXIsIGlmIG5lZWQgYmUuICBXZSB3aWxsCiAJICAgY2hhbmdlIHNvbWUgb2YgdGhl
c2UgbGF0ZXIgKi8KIAljdXJyZW50LT5tbS0+cnNzID0gMDsKLQlzZXR1cF9hcmdfcGFnZXMoYnBy
bSk7IC8qIFhYWDogY2hlY2sgZXJyb3IgKi8KKwlyZXR2YWwgPSBzZXR1cF9hcmdfcGFnZXMoYnBy
bSk7CisgICAgaWYgKHJldHZhbCA8IDApIHsKKwkJLyogU29tZW9uZSBjaGVjay1tZTogaXMgdGhp
cyBlcnJvciBwYXRoIGVub3VnaD8gKi8KKwkJc2VuZF9zaWcoU0lHS0lMTCwgY3VycmVudCwgMCk7
CisJCXJldHVybiByZXR2YWw7CisJfQorCQogCWN1cnJlbnQtPm1tLT5zdGFydF9zdGFjayA9IGJw
cm0tPnA7Ci0KIAkvKiBOb3cgd2UgZG8gYSBsaXR0bGUgZ3J1bmd5IHdvcmsgYnkgbW1hcGluZyB0
aGUgRUxGIGltYWdlIGludG8KIAkgICB0aGUgY29ycmVjdCBsb2NhdGlvbiBpbiBtZW1vcnkuICBB
dCB0aGlzIHBvaW50LCB3ZSBhc3N1bWUgdGhhdAogCSAgIHRoZSBpbWFnZSBzaG91bGQgYmUgbG9h
ZGVkIGF0IGZpeGVkIGFkZHJlc3MsIG5vdCBhdCBhIHZhcmlhYmxlCg==

--Multipart_Wed__22_Aug_2001_03:52:58_+0400_081ee798--
