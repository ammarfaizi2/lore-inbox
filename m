Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288246AbSATLVy>; Sun, 20 Jan 2002 06:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288245AbSATLVp>; Sun, 20 Jan 2002 06:21:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:39344 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288246AbSATLV2>;
	Sun, 20 Jan 2002 06:21:28 -0500
Date: Sun, 20 Jan 2002 14:18:54 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [sched] [patch] activate-task-speedup-2.5.3-pre2-A0
In-Reply-To: <Pine.LNX.4.33.0201201414080.7972-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201201418320.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1600496942-1011532734=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1600496942-1011532734=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


> the attached patch against 2.5.3-pre2 is an optimization of
> activate_task(), to not call effective_prio() if no jiffy passed since
> ->sleep_timestamp was updated. This optimizes high-frequency wakeups.

[attached for real this time.]

	Ingo

--8323328-1600496942-1011532734=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="activate-task-speedup-2.5.3-pre2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201418540.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="activate-task-speedup-2.5.3-pre2-A0"

LS0tIGxpbnV4L2tlcm5lbC9zY2hlZC5jLm9yaWcJU3VuIEphbiAyMCAxMToz
NzowNCAyMDAyDQorKysgbGludXgva2VybmVsL3NjaGVkLmMJU3VuIEphbiAy
MCAxMTozNzoyMSAyMDAyDQpAQCAtMTI2LDkgKzEyNiwxMCBAQA0KIA0KIHN0
YXRpYyBpbmxpbmUgdm9pZCBhY3RpdmF0ZV90YXNrKHRhc2tfdCAqcCwgcnVu
cXVldWVfdCAqcnEpDQogew0KKwl1bnNpZ25lZCBsb25nIHNsZWVwX3RpbWUg
PSBqaWZmaWVzIC0gcC0+c2xlZXBfdGltZXN0YW1wOw0KIAlwcmlvX2FycmF5
X3QgKmFycmF5ID0gcnEtPmFjdGl2ZTsNCiANCi0JaWYgKCFydF90YXNrKHAp
KSB7DQorCWlmICghcnRfdGFzayhwKSAmJiBzbGVlcF90aW1lKSB7DQogCQkv
Kg0KIAkJICogVGhpcyBjb2RlIGdpdmVzIGEgYm9udXMgdG8gaW50ZXJhY3Rp
dmUgdGFza3MuIFdlIHVwZGF0ZQ0KIAkJICogYW4gJ2F2ZXJhZ2Ugc2xlZXAg
dGltZScgdmFsdWUgaGVyZSwgYmFzZWQgb24NCkBAIC0xMzYsNyArMTM3LDcg
QEANCiAJCSAqIHRoZSBoaWdoZXIgdGhlIGF2ZXJhZ2UgZ2V0cyAtIGFuZCB0
aGUgaGlnaGVyIHRoZSBwcmlvcml0eQ0KIAkJICogYm9vc3QgZ2V0cyBhcyB3
ZWxsLg0KIAkJICovDQotCQlwLT5zbGVlcF9hdmcgKz0gamlmZmllcyAtIHAt
PnNsZWVwX3RpbWVzdGFtcDsNCisJCXAtPnNsZWVwX2F2ZyArPSBzbGVlcF90
aW1lOw0KIAkJaWYgKHAtPnNsZWVwX2F2ZyA+IE1BWF9TTEVFUF9BVkcpDQog
CQkJcC0+c2xlZXBfYXZnID0gTUFYX1NMRUVQX0FWRzsNCiAJCXAtPnByaW8g
PSBlZmZlY3RpdmVfcHJpbyhwKTsNCg==
--8323328-1600496942-1011532734=:7972--
