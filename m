Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262732AbSJGUKn>; Mon, 7 Oct 2002 16:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262728AbSJGUJ3>; Mon, 7 Oct 2002 16:09:29 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:20212 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262732AbSJGUHP>; Mon, 7 Oct 2002 16:07:15 -0400
Subject: Re: The end of embedded Linux?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: simon@baydel.com
Cc: "David S. Miller" <davem@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DA1CF36.19659.13D4209@localhost>
References: <3DA16A9B.7624.4B0397@localhost> 
	<3DA1CF36.19659.13D4209@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 07 Oct 2002 21:22:38 +0100
Message-Id: <1034022158.26550.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-07 at 18:15, simon@baydel.com wrote:
> a serial port and an interupt controller. What I was trying to explain 
> was that I would not mind making my code available for these 
> kernel changes. Although I don't understand why anyone would 
> want it. Apart from API changes, why do this ? The kernel is not 
> easily or frequently changed on this type of system. It would bloat 
> the kernel and I would expect to have to address problems of this 
> nature myself.  However I would not like to make code available for 
> the more specialised hardware. 

That depends how specialized the hardware actually is. I think I've see
six different non free implementations of 68360 sync serial code around
all proprietary for example.

Also my original comments were much more aimed at the core stuff. People
who made existing and especially core stuff smaller could send the stuff
out. Several of us want to compile a CONFIG_TINY option, and suprisingly
enough small is good on high end boxes. My L1 cache is 8 times faster
than my L2 cache is 7 times faster than my memory. Or to put it another
way, going to main memory costs me maybe 100 instructions.

My Athlon thinks small is good too!

