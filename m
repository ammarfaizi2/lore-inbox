Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbSLSAvp>; Wed, 18 Dec 2002 19:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbSLSAvp>; Wed, 18 Dec 2002 19:51:45 -0500
Received: from havoc.daloft.com ([64.213.145.173]:5792 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267455AbSLSAvo>;
	Wed, 18 Dec 2002 19:51:44 -0500
Date: Wed, 18 Dec 2002 19:59:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Till Immanuel Patzschke <tip@inw.de>
Cc: lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219005940.GB10502@gtf.org>
References: <3E0116D6.35CA202A@inw.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E0116D6.35CA202A@inw.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 04:46:15PM -0800, Till Immanuel Patzschke wrote:
> Dear List(s),
> 
> as part of my project I need to run a very high number of processes/threads on a
> linux machine.  Right now I have a Dual-PIII 1.4G w/ 8GB RAM -- I am running
> 4000 processes w/ 2-3 threads each totaling in a process count of 15000+
> processes (since Linux doesn't really distinguish between threads and
> processes...).
> Once I pass the 10000 (+/-) pocesses load increases drastically (on startup,
> although it returns to normal), however the system time (on one processor)
> reaches for 54% (12061 procs) while the only non sleeping process is top -- the
> system is basically doing nothing (except scheduling the "nothing" which
> consumes significant system time).
> Is there anything I can do to reduce that system load/time?  (I haven't been
> able to exactly define the "line" but it definitly gets worse the more processes
> need to be handled.)

Redesign your program to not do silly things like this.

Unless you have hardware with 5000 or more CPUs...

	Jeff



