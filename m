Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264690AbTAVX10>; Wed, 22 Jan 2003 18:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbTAVX10>; Wed, 22 Jan 2003 18:27:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49652 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S264690AbTAVX1Z>;
	Wed, 22 Jan 2003 18:27:25 -0500
Message-ID: <3E2F2ACB.E74DEFBC@mvista.com>
Date: Wed, 22 Jan 2003 15:35:39 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-14smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sanders <developer_linux@yahoo.com>
CC: redhat-list@redhat.com, linux-kernel@vger.kernel.org,
       redhat-devel-list@redhat.com
Subject: Re: Linux application level timers?
References: <20030122221703.42913.qmail@web9806.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sanders wrote:
> 
> I'm writing an application server which receives
> requests from other applications. For each request
> received, I want to start a timer so that I can fail
> the application request if it could not be completed
> in max specified time.
> 
> Which Linux timer facility can be used for this?
> 
> I have checked out alarm() and signal() system calls,
> but these calls doesn't take an argument, so its not
> possible to associate application request with the
> matured alarm.

Sounds like a job for POSIX clocks & timers.  See here:
http://sourceforge.net/projects/high-res-timers/

-g
> 
> Any inputs?
> 
> Thanks in advance,
> Tom
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
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
