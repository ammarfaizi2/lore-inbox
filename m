Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280064AbRJaEhR>; Tue, 30 Oct 2001 23:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280062AbRJaEhH>; Tue, 30 Oct 2001 23:37:07 -0500
Received: from [208.129.208.52] ([208.129.208.52]:33540 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S280065AbRJaEgx>;
	Tue, 30 Oct 2001 23:36:53 -0500
Date: Tue, 30 Oct 2001 20:45:02 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Kravetz <kravetz@us.ibm.com>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler
 ...
In-Reply-To: <20011030212940.A1037@w-mikek2.sequent.com>
Message-ID: <Pine.LNX.4.40.0110302044030.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Mike Kravetz wrote:

> On Tue, Oct 30, 2001 at 05:06:16PM -0800, Davide Libenzi wrote:
> > On Tue, 30 Oct 2001, Mike Kravetz wrote:
> > > --------------------------------------------------------------------
> > > Chat - VolanoMark simulator.  Result is a measure of throughput.
> > >        Higher is better.
> > > --------------------------------------------------------------------
> >
> > How does this test work exactly ?
> > Did You measure the run queue length while this was running ?
> > I'm going to modify LatSched to output other info like rqlen and
> > tsk->counter at switch time.
> > I'd like to have a  schedcnt  dump while this test is running.
> > Anyway this test shows that what i'm doing now ( working on the balancing
> > schemes ) is not wasted time :)
>
> Take a look at our OLS presentation slides starting at:
>
> http://lse.sourceforge.net/scheduling/ols2001/img50.htm
>
> This is basically a message passing (via sockets) benchmark with
> high thread counts/runqueue lengths.

Are threads pre-created at startup or are dynamic ?



- Davide


