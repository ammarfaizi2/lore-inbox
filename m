Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbRENObA>; Mon, 14 May 2001 10:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbRENOav>; Mon, 14 May 2001 10:30:51 -0400
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:60639 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S262100AbRENOai>; Mon, 14 May 2001 10:30:38 -0400
Date: Mon, 14 May 2001 15:30:37 +0100 (BST)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Reply-To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Linus Torwalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.5-pre1: tiny NLS include fix
Message-ID: <Pine.SOL.3.96.1010514152513.13662A-200000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-851401618-989850637=:13662"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-851401618-989850637=:13662
Content-Type: TEXT/PLAIN; charset=US-ASCII

Linus,

Please apply attached patch. It puts a #ifndef;#define;#endif block around
the contents of linux/include/linux to allow for multiple #includes of
<linux/nls.h>.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


---559023410-851401618-989850637=:13662
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="nls.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.3.96.1010514153037.13662B@libra.cus.cam.ac.uk>
Content-Description: 

LS0tIGxpbnV4L2luY2x1ZGUvbGludXgvbmxzLmgub2xkCU1vbiBNYXkgMTQg
MTU6MjA6MTYgMjAwMQ0KKysrIGxpbnV4L2luY2x1ZGUvbGludXgvbmxzLmgJ
TW9uIE1heSAxNCAxNToyNDo0MSAyMDAxDQpAQCAtMSwzICsxLDYgQEANCisj
aWZuZGVmIF9MSU5VWF9OTFNfSA0KKyNkZWZpbmUgX0xJTlVYX05MU19IDQor
DQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCiANCiAvKiB1bmljb2RlIGNo
YXJhY3RlciAqLw0KQEAgLTI4LDMgKzMxLDYgQEANCiBleHRlcm4gaW50IHV0
ZjhfbWJzdG93Y3Mod2NoYXJfdCAqLCBjb25zdCBfX3U4ICosIGludCk7DQog
ZXh0ZXJuIGludCB1dGY4X3djdG9tYihfX3U4ICosIHdjaGFyX3QsIGludCk7
DQogZXh0ZXJuIGludCB1dGY4X3djc3RvbWJzKF9fdTggKiwgY29uc3Qgd2No
YXJfdCAqLCBpbnQpOw0KKw0KKyNlbmRpZiAvKiBfTElOVVhfTkxTX0ggKi8N
CisNCg==
---559023410-851401618-989850637=:13662--
