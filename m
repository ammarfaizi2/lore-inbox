Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265314AbRFVH23>; Fri, 22 Jun 2001 03:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265313AbRFVH2U>; Fri, 22 Jun 2001 03:28:20 -0400
Received: from web13605.mail.yahoo.com ([216.136.175.116]:26384 "HELO
	web13605.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265112AbRFVH2C>; Fri, 22 Jun 2001 03:28:02 -0400
Message-ID: <20010622072801.95429.qmail@web13605.mail.yahoo.com>
Date: Fri, 22 Jun 2001 00:28:01 -0700 (PDT)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: Is it useful to support user level drivers
To: D.A.Fedorov@inp.nsk.su, Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Balbir Singh <balbir_soni@yahoo.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.10.10106221043470.3059659-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks folks, I got some great comments, pointers a
list of problems which I need to take care of.
I promise that when I try and implement user
level interrupts - it won't be a hack, all problems
will be taken  care of based on good programming
practices.

I will look into the steps provided by people.
Yes! we need to worry about shared interrupts, I will
draw out a more detailed plan of problems and
solutions.

Later ...

Thanks,
Balbir


--- "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
wrote:
> On Thu, 21 Jun 2001, Oliver Neukum wrote:
> 
> > > > In addition, how do you handle shared
> interrupts ?
> > >
> > > It is impossible, see my another message.
> > 
> > Which IMHO makes the concept pretty much useless.
> > Interrupt sharing is pretty much the norm today.
> And there is no evidence for 
> > this to change in the near future. Rather the
> opposite seems to happen in 
> > fact.
> > 
> > Which devices were you thinking of, that need a
> hardware IRQ and no kernel 
> > driver ?
> 
> An ISA cards, mostly for data acquisition - edge
> triggered interrupts,
> no ack required immediately from interrupt handler.
> Rest of hardware
> handling can be deferred to user space.
> IRQ sharing is possible there in spite of some
> hardware hacking.
> 
> Yes, it is very limited range of hardware today but
> it exists
> and /dev/irq kernel module provide one of generic
> mechanisms for user
> space driver implementation.
> 


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
