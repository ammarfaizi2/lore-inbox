Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264322AbRFHVXY>; Fri, 8 Jun 2001 17:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264327AbRFHVXQ>; Fri, 8 Jun 2001 17:23:16 -0400
Received: from [194.102.102.3] ([194.102.102.3]:62982 "HELO ns1.Aniela.EU.ORG")
	by vger.kernel.org with SMTP id <S264322AbRFHVXK>;
	Fri, 8 Jun 2001 17:23:10 -0400
Date: Sat, 9 Jun 2001 00:22:50 +0300 (EEST)
From: "L. K." <lk@Aniela.EU.ORG>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Michael H. Warfield" <mhw@wittsend.com>, Chris Boot <bootc@worldnet.fr>,
        mirabilos {Thorsten Glaser} <isch@ecce.homeip.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: temperature standard - global config option?
In-Reply-To: <200106082116.f58LGd2497562@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.21.0106090018110.4712-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Jun 2001, Albert D. Cahalan wrote:

> Michael H. Warfiel writes:
> 
> > We don't have sensors that are accurate to 1/10 of a K and certainly not
> > to 1/100 of a K.  Knowing the CPU temperature "precise" to .01 K when
> > the accuracy of the best sensor we are likely to see is no better than
> > +- 1 K is just about as relevant as negative absolute temperatures.
> ...
> > 	Even if we had or could, anticiplate, sensors with a +- .01 K,
> > the relevance of knowing the CPU temperature to that precision is
> > lost on me.  I see no sense in stuffing a field with meaningless
> > bits just because the field will hold them.  In fact, this "false precision"
> > quickly leads to the false impression of accuracy.  Based on several
> > messages I have seen on this thread and in private E-Mail, there are a
> > number of people who don't seem to grasp the fundamental difference
> > between precision and accuracy and truely don't understand that adding
> > meaningless precision like this adds nothing to the accuracy.
> >
> > 	I can see maybe making it precise to .1 K.  But stuffing the bits
> > in there to be precise to .01 K just because we have the bits and not
> > because we have any realistic information to fill the bits in with, is
> > just silly to me.  Just as silly as allowing for negative numbers in an
> > absolute temperature field.  We have the bits to support it, but why?
> 
> The bits are free; the API is hard to change.
> Sensors might get better, at least on high-end systems.
> Rounding gives a constant 0.15 degree error.
> Only the truly stupid would assume accuracy from decimal places.
> Again, the bits are free; the API is hard to change.
> 
> One might provide other numbers to specify accuracy and precision.
> 

I really do not belive that for a CPU or a motherboard +- 1 degree would
make any difference.

If a CPU runs fine at, say, 37 degrees C, I do not belive it will have any
problems running at 38 or 36 degrees. I support the ideea of having very
good sensors for temperature monitoring, but CPU and motherboard
temperature do not depend on the rise of the temperature of 1 degree, but
when the temperature rises 10 or more degrees. I hope you understand what
I want to say.



Regards,


> 

