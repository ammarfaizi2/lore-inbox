Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262587AbSJGRSv>; Mon, 7 Oct 2002 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262586AbSJGRSt>; Mon, 7 Oct 2002 13:18:49 -0400
Received: from anchor-post-39.mail.demon.net ([194.217.242.80]:41179 "EHLO
	anchor-post-39.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262584AbSJGRSn>; Mon, 7 Oct 2002 13:18:43 -0400
From: "" <simon@baydel.com>
To: "David S. Miller" <davem@redhat.com>
Date: Mon, 7 Oct 2002 18:15:18 +0100
MIME-Version: 1.0
Content-type: text/enriched; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: The end of embedded Linux?
CC: linux-kernel@vger.kernel.org
Message-ID: <3DA1CF36.19659.13D4209@localhost>
In-reply-to: <20021007.033644.85392050.davem@redhat.com>
References: <3DA16A9B.7624.4B0397@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, 


Thanks for the reply. I sense as in many emails regarding this a 
sense of frustration and this is a concern. I am writing to the list to 
try and learn and because I value the experiences of other people. 


As far as my hardware is concerned there is much more to it than 
a serial port and an interupt controller. What I was trying to explain 
was that I would not mind making my code available for these 
kernel changes. Although I don't understand why anyone would 
want it. Apart from API changes, why do this ? The kernel is not 
easily or frequently changed on this type of system. It would bloat 
the kernel and I would expect to have to address problems of this 
nature myself.  However I would not like to make code available for 
the more specialised hardware. 

   

Thanks


Simon.


<color><param>0100,0100,0100</param>On 7 Oct 2002, at 3:36, David S. Miller wrote:


<color><param>7F00,0000,0000</param>>    From: "" <<simon@baydel.com>

>    Date: Mon, 7 Oct 2002 11:06:03 +0100

> 

>    No one else can run these drivers so 

>    how could I expect someone else to maintain them ?

> 

> This is a common misconception.  When sweeping API changes

> are made to fix some bug or whatever, if your driver is in

> the tree the person making the API change will update your

> driver or add a comment saying "the new API does this, I

> couldn't figure out how to do that with your driver, please

> update" in a comment.

> 

> You get free work like this just as a side effect of being

> in the tree.

> 

> It will also be sanity build checked by lots of people who

> run the current kernels through a "enable everything" configuration.

>    

>    However I can not understand how it would be practical for many

>    organizations  to  release code under the GPL for specific hardware.

> 

> See above.

> 

>    This to some companies is too much to give 

>    away. Perhaps someone could educate me on this point ?

>    

> You talked about an interrupt controller, a serial port, lack of VGA,

> and lack of RTC on your system... doesn't sound like any ground

> breaking hardware to me.

> 

> Franks a lot,

> David S. Miller

> davem@redhat.com



<nofill>
__________________________

Simon Haynes - Baydel 
Phone : 44 (0) 1372 378811
Email : simon@baydel.com
__________________________
