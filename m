Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135215AbRDZIsz>; Thu, 26 Apr 2001 04:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135216AbRDZIsv>; Thu, 26 Apr 2001 04:48:51 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:48653 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S135215AbRDZIsi>; Thu, 26 Apr 2001 04:48:38 -0400
Message-ID: <3AE7E25B.6E81783E@opersys.com>
Date: Thu, 26 Apr 2001 04:54:51 -0400
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Event tools, do they exist
In-Reply-To: <3AE61FF2.DF9849BB@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hellor George,

As others have suggested, you can do what you are asking for using LTT
(http://www.opersys.com/LTT).

Specifically, you may want to use the event allocation capabilities.
This will enable you to add your own events and view these as part
of the trace.

By the way, there are mailing lists for LTT if you're interested to
make a contribution.

Cheers,

Karim

george anzinger wrote:
> 
> This is an attempt to look in the wheel locker.
> 
> I need a simple event sub system for use in the kernel.  I envision at
> least two types of events: the history event and the timing event.
> 
> The timing event would keep track of start/stop times by class.  If, for
> example, I wanted to know how much time the kernel spends doing the
> recalc in schedule() I would put and event start in front of it and an
> end at the other end.  The sub system would note the first event time
> and the cumulative time between all starts and stops on the same event.
> When reported by /proc/ it would give the total event time, the elapsed
> time and the % of processor time for each of the possibly several
> classes.
> 
> The history event would record each events time, location, data1,
> data2.  It would keep N of these (the last N) and report M (M=<N) via
> /proc/.  This list should also be kept in a format that a simple
> debugger can easily examine.
> 
> Somebody must have written these routines and have them in their
> library.  Sure would help if I could have a peek.
> 
> George
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
===================================================
                 Karim Yaghmour
               karym@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
