Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280027AbRKITOj>; Fri, 9 Nov 2001 14:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280029AbRKITO3>; Fri, 9 Nov 2001 14:14:29 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:15497 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S280027AbRKITOP>;
	Fri, 9 Nov 2001 14:14:15 -0500
Date: Fri, 9 Nov 2001 14:14:15 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: David Grant <davidgrant79@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Athlon cooling
In-Reply-To: <Pine.LNX.4.33.0111081752490.2404-100000@twin.uoregon.edu>
Message-ID: <Pine.LNX.4.30.0111091413330.10332-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Joel Jaeggli wrote:

> CONFIG_APM_CPU_IDLE
>
> in the apm setup...
>
> clock throttling is a subject of some debate on the linux kernel list... ;)
> but the apm idle call will at least idle the cpu once the idle loop has
> been running for a while.

Yes, and i believe this is done via judicious use of the 'hlt'
instruction.  Also note that on some older K6's there are problems with
this instruction.. namely it halts the machine altogether!

>
> joelja
>
> On Thu, 8 Nov 2001, David Grant wrote:
>
> > There is a program for Windows called CPUIdle, which cools the Athlon
> > tremendoulsy.  I can get my temp. from 52C down to 36C.  It makes the CPU
> > truly go idle.  Is there anything like this for Linux, and I'm wondering if
> > anyone knows the instructions (and/or signals) which could be used to put
> > the Athlon into this state.  I guess it's more of a question for some APM
> > guys, but I thought some people here might know the interface to the Athlon,
> > and might thus know how this software cooling works.  Actually the low-level
> > apm stuff is part of the kernel right?  so maybe this is on-topic.
> >
> > http://www.cpuidle.de/
> >
> > Cheers,
> > David Grant
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>

