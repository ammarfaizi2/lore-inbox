Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319013AbSHST7g>; Mon, 19 Aug 2002 15:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319014AbSHST7g>; Mon, 19 Aug 2002 15:59:36 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30962 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S319013AbSHST7f>;
	Mon, 19 Aug 2002 15:59:35 -0400
Message-ID: <3D614EFD.EF6B9AFB@mvista.com>
Date: Mon, 19 Aug 2002 13:03:09 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Dave McCracken <dmccr@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] O(1) sys_exit(), threading, scalable-exit-2.5.31-A6
References: <Pine.LNX.4.44.0208192115001.31716-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Mon, 19 Aug 2002, george anzinger wrote:
> 
> > The current way its done, a child can not get the pid of its father and
> > thus would NEED to know it was being traced in order to do anything that
> > required such. [...]
> 
> what do you mean by this? sys_getppid() uses ->real_parent so it gets the
> proper PID.
> 
Oops.  Open mouth, insert foot :)
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
