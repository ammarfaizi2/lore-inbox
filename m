Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262118AbSJFSpI>; Sun, 6 Oct 2002 14:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262124AbSJFSpI>; Sun, 6 Oct 2002 14:45:08 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:17148 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S262118AbSJFSpH>;
	Sun, 6 Oct 2002 14:45:07 -0400
Message-ID: <3DA085DA.A775CDC9@mvista.com>
Date: Sun, 06 Oct 2002 11:50:02 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, giduru@yahoo.com,
       Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The end of embedded Linux?
References: <Pine.LNX.4.10.10210051252130.21833-100000@master.linux-ide.org>
		<20021005205238.47023.qmail@web13201.mail.yahoo.com> 
		<20021005.212832.102579077.davem@redhat.com> <1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> On Sun, 2002-10-06 at 05:28, David S. Miller wrote:
> > Embedded applications tend to have issues which are entirely specific
> > to that embedded project.  As such, those are things that do not
> > belong in a general purpose OS.
> 
> 90% of the embedded Linux problem is not this. Its actually easy to get
> most of the embedded needs into the base kernel - in fact they overlap
> the other worlds a lot.
> 
> Need low power consumption/resource usage - thats S/390 mainframe
> instances and ibm wristwatches.
> 
> Need good cpu control - thats desktop/laptop and embedded
> 
> Need good irq behaviour (pre-empt/low latency) - thats desktop/embedded
> 
> and it carries on like that.
> 
> No the big problem is that each embedded vendor is desperately trying to
> keep their changes out of the mainstream so they can screw each other.
> In doing so the main people they screw are all their customers.
> 
> So if the embedded people want 2.6 to be good at embedded they need to
> get their heads out of their arses and contribute to the mainstream.
> Otherwise they'll always be chasing a moving ball, and a ball most
> people are kicking the other way down the field. Its a simple fact of
> line, if you stick you head up your backside all you get to do is eat
> shit
> 
> (and yes there are some embedded people who do contribute but they are
> sadly a real minority)

Uh, thanks, I think.

-g
> 
> Alan
> 
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
