Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSHWUbJ>; Fri, 23 Aug 2002 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319268AbSHWUbJ>; Fri, 23 Aug 2002 16:31:09 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:7410 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S315870AbSHWUbI>;
	Fri, 23 Aug 2002 16:31:08 -0400
Message-ID: <3D669C6D.5F0D5005@mvista.com>
Date: Fri, 23 Aug 2002 13:34:53 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: ic@aleph1.net, linux-kernel@vger.kernel.org
Subject: Re: process 0
References: <Pine.LNX.3.95.1020823085056.169A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Fri, 23 Aug 2002 ic@aleph1.net wrote:
> 
> > Hi.
> > Maybe this is a little off topic, but does what is the real status of
> > Process 0 (swapper) ?
> > Some people keep telling me it doesn't exist, but on some kernel crashes
> > I can see "process swapper (pid 0, process nr 0, ...)"
> >
> > Can someone help me ?
> 
> Well, it kind-of exists. It's what the CPU does when there is nothing
> else to do. Sort of like:
> 
>                 for(;;)
>                     schedule();
> 
> It's also where it 'goes' if init returns <grin>.

ALSO, FWIW on a N way SMP there will be N process 0s.  So
much for unique pids :)

-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
