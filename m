Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSKVTzH>; Fri, 22 Nov 2002 14:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262266AbSKVTzH>; Fri, 22 Nov 2002 14:55:07 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:29143 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S261346AbSKVTzH>; Fri, 22 Nov 2002 14:55:07 -0500
Message-ID: <3DDE9309.8040806@kegel.com>
Date: Fri, 22 Nov 2002 12:26:49 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows 98)
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
CC: "'george anzinger'" <george@mvista.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Running POSIX Timers tests against HRT implementation
References: <D9223EB959A5D511A98F00508B68C20C0CCC1F80@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fleischer, Julie N wrote:
>>george anzinger wrote:
>>Now, as to this particular issue, the 1003.1b-1993 standard
>>in paragraph 14.2.1.2 says "The effect of setting a clock
>>via clock_settime() on armed per process timers associated
>>with that clock is implementation defined."
> 
> 
> I see.  Since I'm writing tests towards the 1003.1-2001 standards, I'll need
> to be careful where there's a difference between that one and 1003.1b-1993,
> as is the case with this issue.  (If you'd still appreciate knowing the
> deltas, I can still let you know when there is a difference in the
> 1003.1-2001 standard and the current implementation.)
> 
> In the 1003.1-2001 standards, it actually adds the qualifier that the line
> you quoted applies to non-CLOCK_REALTIME clocks.  If I'm interpreting that
> standard correctly, CLOCK_REALTIME clocks should require that absolute
> timers use the latest value of the clock and not behave relatively.
> 
> I'll make sure that I check the 1003.1b-1993 standards as well, though, when
> reporting future issues.

It'd be nice if the test suite had a large number of point tests,
and for each standard, a list of expected passes and fails.
You'd break up the clock_settime test into a couple of point tests,
one for each standard, maybe.
- Dan

