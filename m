Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262968AbSJGKPJ>; Mon, 7 Oct 2002 06:15:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262970AbSJGKPJ>; Mon, 7 Oct 2002 06:15:09 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:36568 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262968AbSJGKPH>; Mon, 7 Oct 2002 06:15:07 -0400
From: "" <simon@baydel.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 7 Oct 2002 11:06:03 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: The end of embedded Linux?
CC: linux-kernel@vger.kernel.org
Message-ID: <3DA16A9B.7624.4B0397@localhost>
References: <20021005.212832.102579077.davem@redhat.com>
In-reply-to: <1033923206.21282.28.camel@irongate.swansea.linux.org.uk>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following this thread I am even more disturbed about the 
embedded Linux world. I do not have any problem with code size, 
and I would have no problem in paying for some kernel development 
should I require it. I would ask questions via this mailing list but I 
would not expect kernel developers to fix problems specific to my 
environment. 

I agree that  the embedded projects are in need of cpu control, irq 
behaviour etc. I can also accept that this is the case for a large 
percentage of embedded projects. I have no real perception of what 
hardware people use their embedded projects but in my case the 
hardware is dedicated to the specific task in hand. To get Linux 
running on the hardware I had to make changes to kernel/lilo code. 
The hardware has it's own type of interrupt controller, no RTC, it's 
own type of serial port, no vga etc. These changes are specific to 
this hardware and are not likely to exist anywhere else. I do not 
expect kernel developers to maintain this and maybe I am missing 
the point completely, but why would anyone want me to distribute 
this code ? More to the point what about the drivers more specific 
to the task of the hardware ?   No one else can run these drivers so 
how could I expect someone else to maintain them ?

The real point of all this is that the kernel developers seem really 
upset about embedded code which is not released under the GPL.
I can understand the desire to keep all of the code free and open. I 
can also understand how upsetting Linux developers must be in 
seeing their code being used for other peoples gain, who do not 
wish to participate in the open source arena. However I can not 
understand how it would be practical for many organizations  to 
release code under the GPL for specific hardware. The only use I 
could see for this is other people taking a look to see how the 
hardware works. This to some companies is too much to give 
away. Perhaps someone could educate me on this point ?

I thought that this was the main problem for embedded projects. If 
this is no the case I would like to know. So I see the end of 
embedded Linux not in the code size or speed sense but in the 
constant battle between organizations wanting to keep their ideas 
to themselves and the kernel developers wanting these 
organizations to distribute GPL code. 


Many Thanks


Simon.










On 6 Oct 2002, at 17:53, Alan Cox wrote:

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
> 
> Alan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
