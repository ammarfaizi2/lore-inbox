Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288685AbSAUWDo>; Mon, 21 Jan 2002 17:03:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288671AbSAUWDf>; Mon, 21 Jan 2002 17:03:35 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:44552 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S287490AbSAUWDZ>; Mon, 21 Jan 2002 17:03:25 -0500
Date: Mon, 21 Jan 2002 18:52:18 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Robert Love <rml@tech9.net>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <1011650506.850.483.camel@phantasy>
Message-ID: <Pine.LNX.4.21.0201211851390.1461-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 21 Jan 2002, Robert Love wrote:

> On Mon, 2002-01-21 at 16:49, yodaiken@fsmlabs.com wrote:
> 
> > > (average of 4 runs of `dbench 16')
> > > 2.5.3-pre1:		25.7608 MB/s
> > > 2.5.3-pre1-preempt:	32.341 MB/s
> > > 
> > > (old, average of 4 runs of `dbench 16')
> > > 2.5.2-pre11:		24.5364 MB/s
> > > 2.5.2-pre11-preempt:	27.5192 MB/s
> 
> > Robert, with all due respect, my tests of dbench show such high
> > variation that 4 miserable runs prove exactly nothing.
> 
> Well you asked for dbench.  Would you prefer 10 runs each?  There were,
> however, no statistical anomalies and the variation was low enough such
> that I suspect I could construct a reasonable confidence interval from
> these 16 runs.
> 
> I've run these tests over and over again sufficiently that the
> repeatability of obtaining improved marks under a preemptive kernel is
> evident to me.
> 
> You can see very old (2.4.6) yet still positive results from Nigel, too:
> http://kpreempt.sourceforge.net.
> 
> I guess the point is, everyone argues preemption is detrimental to
> throughput.  I'm not going to argue that we aren't adding complexity,
> because clearly we are.  But now we have tests showing throughput is
> improved and people still argue.  I've seen the same behavior under
> bonnie, timing kernel compiles, etc ...

Sure, you've seen it. But _why_ it happens ?

That is the point.

