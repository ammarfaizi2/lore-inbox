Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288732AbSAUWWY>; Mon, 21 Jan 2002 17:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288752AbSAUWWO>; Mon, 21 Jan 2002 17:22:14 -0500
Received: from zero.tech9.net ([209.61.188.187]:48657 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288732AbSAUWWJ>;
	Mon, 21 Jan 2002 17:22:09 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        george anzinger <george@mvista.com>, Momchil Velikov <velco@fadata.bg>,
        Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0201211851390.1461-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0201211851390.1461-100000@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 17:26:17 -0500
Message-Id: <1011651978.988.504.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 15:52, Marcelo Tosatti wrote:

> > I guess the point is, everyone argues preemption is detrimental to
> > throughput.  I'm not going to argue that we aren't adding complexity,
> > because clearly we are.  But now we have tests showing throughput is
> > improved and people still argue.  I've seen the same behavior under
> > bonnie, timing kernel compiles, etc ...
> 
> Sure, you've seen it. But _why_ it happens ?
> 
> That is the point.

Daniel just reiterated it, but I suspect we better multitask a mix of
tasks.  I/O-bound tasks that are woken can be run quicker and thus
throughput increases.

I'm not trying to tout preempt-kernel as a throughput solution.  I think
it is a neat and promising side-note to the patch, and one that
benchmarks are correlating.  Ignore it as a statistical error and
consider throughput untouched if you want. 

	Robert Love

