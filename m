Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262899AbSITQiy>; Fri, 20 Sep 2002 12:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262922AbSITQiy>; Fri, 20 Sep 2002 12:38:54 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:11262 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262899AbSITQix>;
	Fri, 20 Sep 2002 12:38:53 -0400
Message-ID: <3D8B5033.CA842CC2@mvista.com>
Date: Fri, 20 Sep 2002 09:43:31 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: anton wilson <anton.wilson@camotion.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: garbage returned from do_gettimeofday
References: <200209182310.TAA18081@nealtech.net> <200209191602.MAA30225@nealtech.net> <200209192243.SAA18356@nealtech.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anton wilson wrote:
> 
> >
> > 1032450154 41056 -- 108690]
> > 1032450154 42045 -- 108690]
> > 1032450154 42056 -- 108690]
> > 1032450154 43045 -- 108690]
> > 1032450154 43056 -- 108690]
> >
> > /*garbage starts here*/
> > 3390722356 1 -- 108690]
> > 1032450154 43090 -- 108690]
> > 3390722356 1 -- 108690]
> > 1032450154 43177 -- 108690]
> > 3390722356 1 -- 108690]
> > 1032450154 43204 -- 108690]
> > 3390722356 1 -- 108690]
> > 1032450154 43257 -- 108690]
> > 3390722356 1 -- 108690]
> > 1032450154 43287 -- 108690]
> > 3390722356 1 -- 108690]
> > /*garbage values stop for now*/
> > 1032450154 44064 -- 108690]
> >
> >
> > 1032450154 44084 -- 108690]
> > 1032450154 44212 -- 108690]
> > 1032450154 45047 -- 108690]
> > 1032450154 45059 -- 108690]
> > 1032450154 46045 -- 108690]
> >
> >
> > I'm using 2.4.19 with rc2, low-latency, premptive, O(1), and kdb patches.
> 
> hmm. The pre-emptive patch skipped my do_gettimeofday call and shot me in the
> foot. ..

Eh, better be a bit more specific and detailed before you go
to the doctor with that foot, else we might amputate :)

-g
> 
> Anton
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
