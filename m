Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWH2A2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWH2A2m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 20:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbWH2A2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 20:28:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26518 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964858AbWH2A2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 20:28:41 -0400
Date: Mon, 28 Aug 2006 17:28:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Paul E McKenney <paulmck@us.ibm.com>
Subject: Re: [PATCH 0/4] RCU: various merge candidates
Message-Id: <20060828172810.00081afa.akpm@osdl.org>
In-Reply-To: <20060829002302.GC32697@in.ibm.com>
References: <20060828160845.GB3325@in.ibm.com>
	<20060828120611.afad8b0f.akpm@osdl.org>
	<20060828191642.GA32697@in.ibm.com>
	<20060828124058.cca5f5ab.akpm@osdl.org>
	<20060829002302.GC32697@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2006 05:53:02 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> > >
> > > rcutorture fix patches independent of rcu implementation changes
> > > in this patchset.
> > 
> > So this patchset is largely orthogonal to the presently-queued stuff?
> 
> Yes, it should be.

OK.

> > > > Now what?
> > > 
> > > Heh. I can always re-submit against -mm after I wait for a day or two
> > > for comments :)
> > 
> > That would be good, thanks.  We were seriously considering merging all the
> > SRCU stuff for 2.6.18, because
> 
> I think non-srcu rcutorture patches can be merged in 2.6.19. srcu
> is a tossup. Perhaps srcu and this patchset may be merge candidates
> for 2.6.20 should things go well in review and testing.

Oh.  I was planning on merging *rcu* into 2.6.19-rc1.

> Should I re-submit
> against 2.6.18-mm1 or so (after your patchset reduces in size) ?
> What is a convenient time ?

Any time..

> GAh! cpufreq.

heh.
