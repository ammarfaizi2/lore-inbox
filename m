Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261829AbSJVGsU>; Tue, 22 Oct 2002 02:48:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262250AbSJVGsU>; Tue, 22 Oct 2002 02:48:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:44270 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261829AbSJVGsS>;
	Tue, 22 Oct 2002 02:48:18 -0400
Message-ID: <3DB4F5EC.EE8B20FC@mvista.com>
Date: Mon, 21 Oct 2002 23:53:32 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: landley@trommello.org
CC: Robert Love <rml@tech9.net>, george@mvista.net,
       georgeanz@users.sourceforge.net, Jeff Garzik <jgarzik@pobox.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Son of crunch time: the list v1.2.
References: <20021021135137.2801edd2.rusty@rustcorp.com.au> <200210211642.10435.landley@trommello.org> <1035256849.1044.3.camel@phantasy> <200210211900.42772.landley@trommello.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Monday 21 October 2002 22:20, Robert Love wrote:
> > On Mon, 2002-10-21 at 17:42, Rob Landley wrote:
> 
> > George said he would change the code to meet Linus's issues (re the sub
> > jiffies stuff).  But there was not much debate either way, and I suspect
> > George may in fact be correct.
> 
> Anybody know if he made this change?

Uh, what I will offer is: 
1.) Posix clock & timers  NOT HIGH RES
2.) A three patch set to put in high-res-timers:
   a.) The core kernel timer.c stuff
   b.) The i386 high res stuff
   c.) A patch to increase the POSIX clocks & timers to high
res.
> 
> > George also offered an interface-only version of the patch that
> > implements the POSIX clocks and timers syscalls, without the high
> > resolution support, so it would be nice to at the very least merge the
> > missing POSIX functionality.
> >
> >       Robert Love
> 
> Any comments on which of these three patches Linus should personally have the
> opportunity to turn down after the 27th?
> 
> http://sourceforge.net/projects/high-res-timers

None of them :)  I will post a new set against the latest
kernel.  Working....

-g

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
