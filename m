Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317047AbSFWPrn>; Sun, 23 Jun 2002 11:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317051AbSFWPrn>; Sun, 23 Jun 2002 11:47:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31602 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S317047AbSFWPrm>; Sun, 23 Jun 2002 11:47:42 -0400
To: Daniel Phillips <phillips@arcor.de>
Cc: Nathan Straz <nstraz@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2 and 2.4 performance issues
References: <1024678560.879.27.camel@lpinto> <20020621171058.GA27100@sgi.com>
	<E17LUmL-0001wL-00@starship>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Jun 2002 09:37:13 -0600
In-Reply-To: <E17LUmL-0001wL-00@starship>
Message-ID: <m1d6uiropi.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips <phillips@arcor.de> writes:

> On Friday 21 June 2002 19:10, Nathan Straz wrote:
> > On Fri, Jun 21, 2002 at 05:55:55PM +0100, Luis Pedro de Moura Ribeiro Pinto
> wrote:
> 
> > > I was asked (i'm a company freshman) to perform some tests between
> > > kernel versions 2.2 and 2.4, and after awhile searching i found a good
> > > set of benchmarking tools (aim7) from Caldera linux. 
> > 
> > Benchmarks are evil.  Sure they are useful at times, but for the most
> > part they get misused.
> 
> There's no sense denying evidence that 2.2 outperforms 2.4 under certain
> workloads.  Instead we should just be more determined to root out all
> those problems and deal with them.  There is no inherent design reason
> why 2.4 should be slower than 2.2 in any area at all,

As mentioned earlier in 2.4 with SSE compiled in the context switch
costs will be slightly higher.  So unless this expense can be made up
in another area, or we can hide it with laziness...

But in general I agree.

> however, some
> practical issues, such as IO scheduling still remain and are being
> actively worked on.  

Yep always more work todo :)

> Expect backports from 2.5 later in the 2.4 series.
> For now, the one thing we must not do is risk instability in 2.4, now
> that most users have switched over to it.

Definitely.

Eric
