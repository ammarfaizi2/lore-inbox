Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265266AbSKVTsh>; Fri, 22 Nov 2002 14:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSKVTsg>; Fri, 22 Nov 2002 14:48:36 -0500
Received: from fmr01.intel.com ([192.55.52.18]:1759 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265243AbSKVTse>;
	Fri, 22 Nov 2002 14:48:34 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C0CCC1F80@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george anzinger'" <george@mvista.com>,
       "Fleischer, Julie N" <julie.n.fleischer@intel.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: RE: Running POSIX Timers tests against HRT implementation
Date: Fri, 22 Nov 2002 11:55:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> george anzinger wrote:
> Now, as to this particular issue, the 1003.1b-1993 standard
> in paragraph 14.2.1.2 says "The effect of setting a clock
> via clock_settime() on armed per process timers associated
> with that clock is implementation defined."

I see.  Since I'm writing tests towards the 1003.1-2001 standards, I'll need
to be careful where there's a difference between that one and 1003.1b-1993,
as is the case with this issue.  (If you'd still appreciate knowing the
deltas, I can still let you know when there is a difference in the
1003.1-2001 standard and the current implementation.)

In the 1003.1-2001 standards, it actually adds the qualifier that the line
you quoted applies to non-CLOCK_REALTIME clocks.  If I'm interpreting that
standard correctly, CLOCK_REALTIME clocks should require that absolute
timers use the latest value of the clock and not behave relatively.

I'll make sure that I check the 1003.1b-1993 standards as well, though, when
reporting future issues.

- Julie

**These views are not necessarily those of my employer.**
