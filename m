Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288159AbSATLQy>; Sun, 20 Jan 2002 06:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288205AbSATLQp>; Sun, 20 Jan 2002 06:16:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:22448 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288159AbSATLQa>;
	Sun, 20 Jan 2002 06:16:30 -0500
Date: Sun, 20 Jan 2002 14:13:53 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: [sched] [patch] comment-fixes-2.5.3-pre2-A0
Message-ID: <Pine.LNX.4.33.0201201411230.7818-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1303595027-1011532433=:7818"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1303595027-1011532433=:7818
Content-Type: TEXT/PLAIN; charset=US-ASCII


the attached patch from Rusty Russell fixes three comments in
kernel/sched.c. (I've updated it to apply cleanly against 2.5.3-pre2.)

	Ingo

--8323328-1303595027-1011532433=:7818
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="comment-fixes-2.5.3-pre2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201413530.7818@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="comment-fixes-2.5.3-pre2-A0"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJU3VuIEphbiAyMCAxMDo0
MTozOSAyMDAyDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJU3VuIEphbiAy
MCAxMDo1NzoxNyAyMDAyDQpAQCAtMzcsMTEgKzM3LDcgQEANCiAgKg0KICAq
IExvY2tpbmcgcnVsZTogdGhvc2UgcGxhY2VzIHRoYXQgd2FudCB0byBsb2Nr
IG11bHRpcGxlIHJ1bnF1ZXVlcw0KICAqIChzdWNoIGFzIHRoZSBsb2FkIGJh
bGFuY2luZyBvciB0aGUgcHJvY2VzcyBtaWdyYXRpb24gY29kZSksIGxvY2sN
Ci0gKiBhY3F1aXJlIG9wZXJhdGlvbnMgbXVzdCBiZSBvcmRlcmVkIGJ5IHRo
ZSBydW5xdWV1ZSdzIGNwdSBpZC4NCi0gKg0KLSAqIFRoZSBSVCBldmVudCBp
ZCBpcyB1c2VkIHRvIGF2b2lkIGNhbGxpbmcgaW50byB0aGUgdGhlIFJUIHNj
aGVkdWxlcg0KLSAqIGlmIHRoZXJlIGlzIGEgUlQgdGFzayBhY3RpdmUgaW4g
YW4gU01QIHN5c3RlbSBidXQgdGhlcmUgaXMgbm8NCi0gKiBSVCBzY2hlZHVs
aW5nIGFjdGl2aXR5IG90aGVyd2lzZS4NCisgKiBhY3F1aXJlIG9wZXJhdGlv
bnMgbXVzdCBiZSBvcmRlcmVkIGJ5IGFzY2VuZGluZyAmcnVucXVldWUuDQog
ICovDQogc3RydWN0IHJ1bnF1ZXVlIHsNCiAJc3BpbmxvY2tfdCBsb2NrOw0K
QEAgLTUzOCw3ICs1NTMsNyBAQA0KIAkgKiBkbyBub3QgdXBkYXRlIGEgcHJv
Y2VzcydzIHByaW9yaXR5IHVudGlsIGl0IGVpdGhlcg0KIAkgKiBnb2VzIHRv
IHNsZWVwIG9yIHVzZXMgdXAgaXRzIHRpbWVzbGljZS4gVGhpcyBtYWtlcw0K
IAkgKiBpdCBwb3NzaWJsZSBmb3IgaW50ZXJhY3RpdmUgdGFza3MgdG8gdXNl
IHVwIHRoZWlyDQotCSAqIHRpbWVzbGljZXMgYXQgdGhlaXIgaGlnaCBwcmlv
cml0eSBsZXZlbHMuDQorCSAqIHRpbWVzbGljZXMgYXQgdGhlaXIgaGlnaGVz
dCBwcmlvcml0eSBsZXZlbHMuDQogCSAqLw0KIAlpZiAocC0+c2xlZXBfYXZn
KQ0KIAkJcC0+c2xlZXBfYXZnLS07DQpAQCAtODUzLDcgKzgzOCw3IEBADQog
CWlmIChhcnJheSkgew0KIAkJZW5xdWV1ZV90YXNrKHAsIGFycmF5KTsNCiAJ
CS8qDQotCQkgKiBJZiB0aGUgdGFzayBpcyBydW5uYWJsZSBhbmQgbG93ZXJl
ZCBpdHMgcHJpb3JpdHksDQorCQkgKiBJZiB0aGUgdGFzayBpcyBydW5uaW5n
IGFuZCBsb3dlcmVkIGl0cyBwcmlvcml0eSwNCiAJCSAqIG9yIGluY3JlYXNl
ZCBpdHMgcHJpb3JpdHkgdGhlbiByZXNjaGVkdWxlIGl0cyBDUFU6DQogCQkg
Ki8NCiAJCWlmICgobmljZSA8IHAtPl9fbmljZSkgfHwNCg==
--8323328-1303595027-1011532433=:7818--
