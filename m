Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280391AbRKEJDB>; Mon, 5 Nov 2001 04:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280392AbRKEJC6>; Mon, 5 Nov 2001 04:02:58 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:62604 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S280391AbRKEJCl>; Mon, 5 Nov 2001 04:02:41 -0500
Date: Mon, 5 Nov 2001 11:14:10 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.13-ac5-preempt, overflow in cached memory stat?
In-Reply-To: <3BE64FE3.DBEF8E21@zip.com.au>
Message-ID: <Pine.LNX.4.33.0111051110580.6741-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Andrew Morton wrote:

> Robert Love wrote:
> >
> > > PS I know you keep hearing this, but that preempt patch makes for some
> > > damn smooth interactive performance ;)
> >
> > I can't hear it enough :)
> >
>
> umm...  Look.  Sorry.  But I don't see any theoretical reason
> why interactivity should be noticeably different from the
> little patch at
>
> http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.14pre7aa2/00_lowlatency-fixes-2
>
> and I did some quantitative testing a week or so back which
> bears this out.  With either patch, worst-case latencies
> are very rare, and very bad.   Usual latencies are excellent.
>
> Is there any reason why preempt should be noticeably better than
> that little patch?  If it is, then where on earth are the
> problematic commonly-occuring, long-running, lock-free code paths?

Unfortunately i haven't tested that patch so i can't provide an objective
comparison. In which case are there patches for -ac? because if not there
might also be other factors influencing the "perception" of improved
interactivity, this is mainly because i'm doing "tests" by just plain
using the box for an extended period instead of "real" scientific tests.

Regards,
	Zwane Mwaikambo
>
> -
>

