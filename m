Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSKVUZb>; Fri, 22 Nov 2002 15:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263794AbSKVUZb>; Fri, 22 Nov 2002 15:25:31 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:758 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S263321AbSKVUZa>;
	Fri, 22 Nov 2002 15:25:30 -0500
Message-ID: <3DDE9442.C6011D23@mvista.com>
Date: Fri, 22 Nov 2002 12:32:02 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
CC: high-res-timers-discourse@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: Running POSIX Timers tests against HRT implementation
References: <D9223EB959A5D511A98F00508B68C20C0CCC1F80@orsmsx108.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Fleischer, Julie N" wrote:
> 
> > george anzinger wrote:
> > Now, as to this particular issue, the 1003.1b-1993 standard
> > in paragraph 14.2.1.2 says "The effect of setting a clock
> > via clock_settime() on armed per process timers associated
> > with that clock is implementation defined."
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

Well darn.  I was unaware of this change.  I will see what
can be done to change the code....

-g
> 
> I'll make sure that I check the 1003.1b-1993 standards as well, though, when
> reporting future issues.
> 
> - Julie
> 

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
