Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316751AbSGLS1v>; Fri, 12 Jul 2002 14:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316753AbSGLS1u>; Fri, 12 Jul 2002 14:27:50 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39157 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S316751AbSGLS1t>;
	Fri, 12 Jul 2002 14:27:49 -0400
Message-ID: <3D2F1225.C46E4B42@mvista.com>
Date: Fri, 12 Jul 2002 10:30:13 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Stevie O <oliver@klozoff.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.10.10207110847170.6183-100000@zeus.compusonic.fi>
		<5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
		<3D2E2C48.DCB509D7@mvista.com> <52adoxrb1f.fsf@topspin.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> 
> >>>>> "george" == george anzinger <george@mvista.com> writes:
> 
>     george> Well, in truth it has nothing to do with interrupts.  It
>     george> is just that that is the way most systems keep time.  The
>     george> REAL definition of HZ is in its relationship to jiffies
>     george> and seconds.
> 
>     george> I.e. jiffies * HZ = seconds, by definition.
> 
> I'm sure you know the truth, but this isn't quite right.  Just to be
> pedantic and make sure the correct definition is out there:
> 
>   jiffies / HZ = seconds
> 
> For example if HZ is 100 then the jiffy counter is incremented 100
> times each second.
> 
Of course you are right.  Must have been a brain fart :)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
