Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289149AbSANXAg>; Mon, 14 Jan 2002 18:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289156AbSANXA0>; Mon, 14 Jan 2002 18:00:26 -0500
Received: from [203.6.240.4] ([203.6.240.4]:63753 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S289167AbSANXAJ>; Mon, 14 Jan 2002 18:00:09 -0500
Message-ID: <370747DEFD89D2119AFD00C0F017E66156A8DC@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 15 Jan 2002 09:59:45 +1100
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Google is your fried ;)

I believe Dawson Engler engler@csl.Stanford.EDU is the man to contact.  More
info about their project can be found at http://hands.stanford.edu/linux/

You would probably need to give him an example of the bad code you are
trying to catch

-Robert

> -----Original Message-----
> From: george anzinger [mailto:george@mvista.com]
> Sent: Tuesday, January 15, 2002 6:52 AM
> To: Robert Lowery
> Cc: linux-kernel@vger.kernel.org; andrea@suse.de
> Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> Robert Lowery wrote:
> > 
> > >I question this because it is too risky to apply. There is 
> no way any
> > >distribution or production system could ever consider applying the
> > >preempt kernel and ship it in its next kernel update 2.4. 
> You never know
> > >if a driver will deadlock because it is doing a test and 
> set bit busy
> > >loop by hand instead of using spin_lock and you cannot 
> audit all the
> > >device drivers out there.
> > 
> > Quick question from a kernel newbie.
> > 
> > Could this audit be partially automated by the Stanford 
> Checker? or would
> > there
> > be too many false positives from other similar looping code?
> > 
> > -Robert
> Sounds like a REALLY good thing (tm) to me.  How do we get them
> interested?
> -- 
> George           george@mvista.com
> High-res-timers: http://sourceforge.net/projects/high-res-timers/
> Real time sched: http://sourceforge.net/projects/rtsched/
> 
