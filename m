Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263874AbRFEI1Z>; Tue, 5 Jun 2001 04:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFEI1Q>; Tue, 5 Jun 2001 04:27:16 -0400
Received: from chiara.elte.hu ([157.181.150.200]:29967 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S263742AbRFEI1C>;
	Tue, 5 Jun 2001 04:27:02 -0400
Date: Tue, 5 Jun 2001 10:25:00 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: George Bonser <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.6-pre1 unresolved symbols
In-Reply-To: <CHEKKPICCNOGICGMDODJKENIDDAA.george@gator.com>
Message-ID: <Pine.LNX.4.33.0106051023530.2339-200000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1166221113-991729500=:2339"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-1166221113-991729500=:2339
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Tue, 5 Jun 2001, George Bonser wrote:

> depmod:         do_softirq
> depmod:         tasklet_hi_schedule

forgot about those - the attached softirq-2.4.6-A0 patch exports these
symbols.

	Ingo

--8323328-1166221113-991729500=:2339
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="softirq-2.4.6-A0"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0106051025000.2339@localhost.localdomain>
Content-Description: 
Content-Disposition: attachment; filename="softirq-2.4.6-A0"

LS0tIGxpbnV4L2tlcm5lbC9rc3ltcy5jLm9yaWcJVHVlIEp1biAgNSAwOTo1
OTo0NCAyMDAxDQorKysgbGludXgva2VybmVsL2tzeW1zLmMJVHVlIEp1biAg
NSAxMDowMDoxOCAyMDAxDQpAQCAtNTM1LDYgKzUzNSw5IEBADQogRVhQT1JU
X1NZTUJPTCh0YXNrbGV0X2luaXQpOw0KIEVYUE9SVF9TWU1CT0wodGFza2xl
dF9raWxsKTsNCiBFWFBPUlRfU1lNQk9MKF9fcnVuX3Rhc2tfcXVldWUpOw0K
K0VYUE9SVF9TWU1CT0woZG9fc29mdGlycSk7DQorRVhQT1JUX1NZTUJPTCh0
YXNrbGV0X3NjaGVkdWxlKTsNCitFWFBPUlRfU1lNQk9MKHRhc2tsZXRfaGlf
c2NoZWR1bGUpOw0KIA0KIC8qIGluaXQgdGFzaywgZm9yIG1vdmluZyBrdGhy
ZWFkIHJvb3RzIC0gb3VnaHQgdG8gZXhwb3J0IGEgZnVuY3Rpb24gPz8gKi8N
CiANCg==
--8323328-1166221113-991729500=:2339--
