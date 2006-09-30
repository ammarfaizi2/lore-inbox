Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWI3SZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWI3SZw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWI3SZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:25:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26807 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751365AbWI3SZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:25:51 -0400
Subject: Re: 2.6.18-rt1
From: Lee Revell <rlrevell@joe-job.com>
To: dipankar@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20060930181804.GA28768@in.ibm.com>
References: <20060920141907.GA30765@elte.hu>
	 <1159639564.4067.43.camel@mindpipe>  <20060930181804.GA28768@in.ibm.com>
Content-Type: text/plain
Date: Sat, 30 Sep 2006 14:25:55 -0400
Message-Id: <1159640756.4067.47.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-30 at 23:48 +0530, Dipankar Sarma wrote:
> On Sat, Sep 30, 2006 at 02:06:04PM -0400, Lee Revell wrote:
> > I got this Oops with -rt3, looks RCU related.  Apologies in advance if
> > it's already known.
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000000 RIP: 
> >  [<ffffffff802aafa7>] __rcu_read_unlock+0x2e/0x82
> > PGD 46a3067 PUD 4e27067 PMD 0 
> > Oops: 0002 [1] PREEMPT SMP 
> > CPU 1 
> 
> I see a very similar crash while running rcutorture on 2.6.18-mm1 and
> my rcu patchset that has rcupreempt stuff rom -rt. I don't see this
> while running on 2.6.18-rc3, but then rc3 had an older version
> of rcutorture. I am working on narrowing it down.
> 
> The following script reproduces the problem quickly (within
> a couple of minutes) in my 4-cpu x86_64 system -

Let me know if you want more info such as config.  I was compiling a
kernel when the Oops occurred.  System is Athlon X2.

Lee

