Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316778AbSFUUNQ>; Fri, 21 Jun 2002 16:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316780AbSFUUNP>; Fri, 21 Jun 2002 16:13:15 -0400
Received: from [213.23.20.221] ([213.23.20.221]:2735 "EHLO starship")
	by vger.kernel.org with ESMTP id <S316778AbSFUUNO>;
	Fri, 21 Jun 2002 16:13:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Nathan Straz <nstraz@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2 and 2.4 performance issues
Date: Fri, 21 Jun 2002 22:13:09 +0200
X-Mailer: KMail [version 1.3.2]
References: <1024678560.879.27.camel@lpinto> <20020621171058.GA27100@sgi.com>
In-Reply-To: <20020621171058.GA27100@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17LUmL-0001wL-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 19:10, Nathan Straz wrote:
> On Fri, Jun 21, 2002 at 05:55:55PM +0100, Luis Pedro de Moura Ribeiro Pinto wrote:
> > I was asked (i'm a company freshman) to perform some tests between
> > kernel versions 2.2 and 2.4, and after awhile searching i found a good
> > set of benchmarking tools (aim7) from Caldera linux. 
> 
> Benchmarks are evil.  Sure they are useful at times, but for the most
> part they get misused.

There's no sense denying evidence that 2.2 outperforms 2.4 under certain
workloads.  Instead we should just be more determined to root out all
those problems and deal with them.  There is no inherent design reason
why 2.4 should be slower than 2.2 in any area at all, however, some
practical issues, such as IO scheduling still remain and are being
actively worked on.  Expect backports from 2.5 later in the 2.4 series.
For now, the one thing we must not do is risk instability in 2.4, now
that most users have switched over to it.

-- 
Daniel
