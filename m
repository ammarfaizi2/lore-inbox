Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132446AbRA3WnR>; Tue, 30 Jan 2001 17:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRA3WnJ>; Tue, 30 Jan 2001 17:43:09 -0500
Received: from www.llamacom.com ([209.152.94.130]:23827 "HELO www.llamacom.com")
	by vger.kernel.org with SMTP id <S132446AbRA3Wmz>;
	Tue, 30 Jan 2001 17:42:55 -0500
Date: Tue, 30 Jan 2001 16:42:52 -0600 (CST)
From: Eric Molitor <emolitor@molitor.org>
To: Jurgen Botz <jurgen@botz.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Wavelan IEEE driver 
In-Reply-To: <200101302222.OAA04184@nova.botz.org>
Message-ID: <Pine.LNX.4.10.10101301637300.27121-100000@www.llamacom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jan 2001, Jurgen Botz wrote:

> Eric Molitor wrote:
> > I updated the Wavelan IEEE driver from 2.3.50 so that it builds with 2.4.0
> > (The 2.3.50 patch is available at
> > http://www.fasta.fh-dortmund.de/users/andy/wvlan/ ) It works for me but
> > I've heard there are issues with firmware 6.xx not initializing.
> > 
> > The patch against 2.4.0 is at http://www.molitor.org/wavelan
> 
> Actually the 1.0.6 driver included in the latest pcmcia-cs packages
> works with 2.4.  Normally, when you build pcmcia-cs against a 2.4
> kernel the modules are not built since they are supposed to be included
> with the kernel... obviously not all of them are, however.  You can
> force it to build the wvlan_cs driver by adding "wireless" to the
> end of DIRS in the top-level makefile.  This will successfully build
> the wvlan_cs module, which can then be inserted into a 2.4 kernel
> and appears to work.  I did observe a problem with iwconfig dumping
> core, but it seems to do its job before it dies, so this may be non-
> critical.
>

Hmm, this probably should be commented in the wavelan.txt file within the
kernel. What is the intention with pcmcia-cs and the kernel in regards to
pcmcia modules. Is the intention to roll the drivers into the kernel 
(ALA the tulip module and other various pcmcia modules in 2.4.xx) or is
the intention to keep them in the pcmcia-cs package.
 
> The 1.0.6 driver is dated Dec-7-2000 and supports all the latest
> "orinico" firmware revisions.  Somebody with the time and inclination
> should probably integrate it into the main kernel source and send a
> patch to Linus.
> 

I'll probably look at doing that when I get back into town next
week. Although that depends on the answer to the above.

Cheers, Eric Molitor

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
