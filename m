Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280059AbRJaEaY>; Tue, 30 Oct 2001 23:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280062AbRJaEaO>; Tue, 30 Oct 2001 23:30:14 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:48819 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S280059AbRJaEaI>;
	Tue, 30 Oct 2001 23:30:08 -0500
Date: Tue, 30 Oct 2001 21:29:41 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030212940.A1037@w-mikek2.sequent.com>
In-Reply-To: <20011030161106.F1097@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0110301629400.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0110301629400.1495-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Tue, Oct 30, 2001 at 05:06:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 05:06:16PM -0800, Davide Libenzi wrote:
> On Tue, 30 Oct 2001, Mike Kravetz wrote:
> > --------------------------------------------------------------------
> > Chat - VolanoMark simulator.  Result is a measure of throughput.
> >        Higher is better.
> > --------------------------------------------------------------------
> 
> How does this test work exactly ?
> Did You measure the run queue length while this was running ?
> I'm going to modify LatSched to output other info like rqlen and
> tsk->counter at switch time.
> I'd like to have a  schedcnt  dump while this test is running.
> Anyway this test shows that what i'm doing now ( working on the balancing
> schemes ) is not wasted time :)

Take a look at our OLS presentation slides starting at:

http://lse.sourceforge.net/scheduling/ols2001/img50.htm

This is basically a message passing (via sockets) benchmark with
high thread counts/runqueue lengths.

I'll kick off the all important 'kernel build benchmark' and have
some results tomorrow.

-- 
Mike
