Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSATLWZ>; Sun, 20 Jan 2002 06:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288283AbSATLWR>; Sun, 20 Jan 2002 06:22:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40624 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288245AbSATLWJ>;
	Sun, 20 Jan 2002 06:22:09 -0500
Date: Sun, 20 Jan 2002 14:19:35 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [sched] [patch] fork-cleanup-2.5.3-pre2-A0
In-Reply-To: <Pine.LNX.4.33.0201201415530.7972-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201201419160.7972-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-904188463-1011532775=:7972"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-904188463-1011532775=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII


> the attached patch against 2.5.3-pre2 removes the child-runs-first
> ifdefs from kernel/fork.c. Very few of the bugreports were related to
> child-runs-first, and for 2.5 i think it's acceptable to introduce
> unconditional child-runs-first.

(attached.)

	Ingo

--8323328-904188463-1011532775=:7972
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fork-cleanup-2.5.3-pre2-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0201201419350.7972@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="fork-cleanup-2.5.3-pre2-A0"

LS0tIGxpbnV4L2tlcm5lbC9mb3JrLmMub3JpZwlTdW4gSmFuIDIwIDEwOjMx
OjUzIDIwMDINCisrKyBsaW51eC9rZXJuZWwvZm9yay5jCVN1biBKYW4gMjAg
MTA6NTc6MTcgMjAwMg0KQEAgLTc0NywyMyArNzQ3LDE2IEBADQogCWlmIChw
LT5wdHJhY2UgJiBQVF9QVFJBQ0VEKQ0KIAkJc2VuZF9zaWcoU0lHU1RPUCwg
cCwgMSk7DQogDQotI2RlZmluZSBSVU5fQ0hJTERfRklSU1QgMQ0KLSNpZiBS
VU5fQ0hJTERfRklSU1QNCiAJd2FrZV91cF9mb3JrZWRfcHJvY2VzcyhwKTsJ
CS8qIGRvIHRoaXMgbGFzdCAqLw0KLSNlbHNlDQotCXdha2VfdXBfcHJvY2Vz
cyhwKTsJCQkvKiBkbyB0aGlzIGxhc3QgKi8NCi0jZW5kaWYNCiAJKyt0b3Rh
bF9mb3JrczsNCiAJaWYgKGNsb25lX2ZsYWdzICYgQ0xPTkVfVkZPUkspDQog
CQl3YWl0X2Zvcl9jb21wbGV0aW9uKCZ2Zm9yayk7DQotI2lmIFJVTl9DSElM
RF9GSVJTVA0KIAllbHNlDQogCQkvKg0KIAkJICogTGV0IHRoZSBjaGlsZCBw
cm9jZXNzIHJ1biBmaXJzdCwgdG8gYXZvaWQgbW9zdCBvZiB0aGUNCiAJCSAq
IENPVyBvdmVyaGVhZCB3aGVuIHRoZSBjaGlsZCBleGVjKClzIGFmdGVyd2Fy
ZHMuDQogCQkgKi8NCiAJCWN1cnJlbnQtPm5lZWRfcmVzY2hlZCA9IDE7DQot
I2VuZGlmDQogDQogZm9ya19vdXQ6DQogCXJldHVybiByZXR2YWw7DQo=
--8323328-904188463-1011532775=:7972--
