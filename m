Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSGSUgu>; Fri, 19 Jul 2002 16:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSGSUgt>; Fri, 19 Jul 2002 16:36:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:50429 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S317022AbSGSUgt>;
	Fri, 19 Jul 2002 16:36:49 -0400
Message-ID: <3D3875E7.BDFC00DE@mvista.com>
Date: Fri, 19 Jul 2002 13:26:15 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dank@kegel.com
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "high-res-timers-discourse@lists.sourceforge.net" 
	<high-res-timers-discourse@lists.sourceforge.net>
Subject: Re: high resolution timers in 2.5? (was: [2.6] The List, pass #2)
References: <3D38442B.FC307ADE@kegel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dank@kegel.com wrote:
> 
> Mark Salisbury wrote:
> > On Friday 19 July 2002 00:47, Guillaume Boissiere wrote:
> > > Would be nice to have before feature freeze, but most likely 2.7:
> > >   o High resolution timers
> >
> > this has been done for almost a year now, what is holding it up?
> 
> I don't know, but it's about time.  George Anziger should know.
> 
> George,
> Have you submitted a high-resolution-timers patch to Linux for 2.5?
> I seem to recall he didn't like the patch when he first saw
> it, but that was so long ago presumably it's much cleaner now?
> - Dan
That was really a very different patch.  The hang up has
been time to work on the code.  There are a few, minor,
changes, like eliminating nanosleep() (it should call
clock_nanosleep()), and then the code clean up to remove all
the debug cruft.  

The next bit I want to submit is the changes to the timer
queue to allow subjiffie timers...

I am hoping to convince my boss to allow me to work on this
full time so I can make some real progress.  As always, any
help will be gratefully accepted :)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
