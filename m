Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274675AbRITWIu>; Thu, 20 Sep 2001 18:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274674AbRITWIj>; Thu, 20 Sep 2001 18:08:39 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44082 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S274673AbRITWIa>; Thu, 20 Sep 2001 18:08:30 -0400
Date: Thu, 20 Sep 2001 18:08:50 -0400
Message-Id: <200109202208.f8KM8o902962@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.4.9-ac10 on Athlon
X-Newsgroups: linux.dev.kernel
In-Reply-To: <Pine.LNX.4.33.0109100015360.22080-100000@terbidium.openservices.net>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0109100015360.22080-100000@terbidium.openservices.net> you write:
| On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:
| 
| > On Sun, 9 Sep 2001, Ignacio Vazquez-Abrams wrote:
| >
| > I have solved the problem. It had to do with the setting of
| > CONFIG_APM_REAL_MODE_POWER_OFF. It has to be on in my case.
| >
| > Is there any time when this option _has_ to be off?
| 
| Sigh. I apologize. This did _not_ work. Does anyone else have any hoops for me
| to jump through?

Look for BIOS updates. I have a BP6 (dual Celeron) system, and I am
really disappointed that the only way I can power it down under software
control is to boot to another o/s. You may be able to get a BIOS which
works.

Note: if you have SMP and the kernel insists on disabling power off
(like it's not thread safe or something?) you can use "lilo -R" to boot
a uni kernel and then shut down.

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
