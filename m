Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSAUV6E>; Mon, 21 Jan 2002 16:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288667AbSAUV5s>; Mon, 21 Jan 2002 16:57:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:26385 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288548AbSAUV5e>;
	Mon, 21 Jan 2002 16:57:34 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: yodaiken@fsmlabs.com
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020121144937.A18422@hq.fsmlabs.com>
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu>
	<E16SgXE-0001i8-00@starship.berlin> <20020121084344.A13455@hq.fsmlabs.com>
	<E16SgwP-0001iN-00@starship.berlin> <20020121090602.A13715@hq.fsmlabs.com>
	<1011647882.8596.466.camel@phantasy>  <20020121144937.A18422@hq.fsmlabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 17:01:45 -0500
Message-Id: <1011650506.850.483.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 16:49, yodaiken@fsmlabs.com wrote:

> > (average of 4 runs of `dbench 16')
> > 2.5.3-pre1:		25.7608 MB/s
> > 2.5.3-pre1-preempt:	32.341 MB/s
> > 
> > (old, average of 4 runs of `dbench 16')
> > 2.5.2-pre11:		24.5364 MB/s
> > 2.5.2-pre11-preempt:	27.5192 MB/s

> Robert, with all due respect, my tests of dbench show such high
> variation that 4 miserable runs prove exactly nothing.

Well you asked for dbench.  Would you prefer 10 runs each?  There were,
however, no statistical anomalies and the variation was low enough such
that I suspect I could construct a reasonable confidence interval from
these 16 runs.

I've run these tests over and over again sufficiently that the
repeatability of obtaining improved marks under a preemptive kernel is
evident to me.

You can see very old (2.4.6) yet still positive results from Nigel, too:
http://kpreempt.sourceforge.net.

I guess the point is, everyone argues preemption is detrimental to
throughput.  I'm not going to argue that we aren't adding complexity,
because clearly we are.  But now we have tests showing throughput is
improved and people still argue.  I've seen the same behavior under
bonnie, timing kernel compiles, etc ...

> Did these even come on the same filesystem?

Yes, why would you suspect otherwise?

	Robert Love

