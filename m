Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268252AbTB1XJl>; Fri, 28 Feb 2003 18:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268266AbTB1XJl>; Fri, 28 Feb 2003 18:09:41 -0500
Received: from packet.digeo.com ([12.110.80.53]:50351 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268252AbTB1XJh>;
	Fri, 28 Feb 2003 18:09:37 -0500
Date: Fri, 28 Feb 2003 15:16:24 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030228151624.2198ea39.akpm@digeo.com>
In-Reply-To: <20030228231220.19048.qmail@linuxmail.org>
References: <20030228231220.19048.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 23:19:51.0758 (UTC) FILETIME=[E51DEEE0:01C2DF7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> ----- Original Message ----- 
> From: Andrew Morton <akpm@digeo.com> 
> Date: Fri, 28 Feb 2003 11:14:18 -0800 
> To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> 
> Subject: Re: anticipatory scheduling questions 
>  
> > "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote: 
> > > I have done so: Evolution is a complex application with many interdependencies and is  
> > > not very prone to launch diagnostic messages to the console. Anyways, I haven't seen  
> > > any diagnostic message in the console. I still think there is something in the AS I/O scheduler  
> > > that is not working at full read throughput. Of course I'm no expert.  
> >  
> > It certainly does appear that way.  But you observed the same runtime 
> > with the deadline scheduler.  Or was that a typo? 
> >  
> > > > 2.4.20-2.54 -> 9s   
> > > > 2.5.63-mm1 w/Deadline -> 34s   
> > > > 2.5.63-mm1 w/AS -> 33s  
>  
> It wasn't a typo... In fact, both deadline and AS give roughly the same
> timings (one second up or down). But I 
> still don't understand why 2.5 is performing so much worse than 2.4.

Me either.  It's a bug.

Does basic 2.5.63 do the same thing?  Do you have a feel for when it started
happening?

> Could a "vmstat" or "iostat" dump be interesting? 

2.4 versus 2.5 would be interesting, yes.


