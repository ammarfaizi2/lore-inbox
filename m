Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVCQPla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVCQPla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 10:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVCQPla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 10:41:30 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:43477 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261569AbVCQPlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 10:41:24 -0500
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503170210530.17019@localhost.localdomain>
References: <Pine.LNX.4.58.0503141024530.697@localhost.localdomain>
	 <Pine.LNX.4.58.0503150641030.6456@localhost.localdomain>
	 <20050315120053.GA4686@elte.hu>
	 <Pine.LNX.4.58.0503150746110.6456@localhost.localdomain>
	 <20050315133540.GB4686@elte.hu>
	 <Pine.LNX.4.58.0503151150170.6456@localhost.localdomain>
	 <20050316085029.GA11414@elte.hu> <20050316011510.2a3bdfdb.akpm@osdl.org>
	 <20050316095155.GA15080@elte.hu> <20050316020408.434cc620.akpm@osdl.org>
	 <20050316101906.GA17328@elte.hu> <20050316024022.6d5c4706.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160600200.11824@localhost.localdomain>
	 <20050316031909.08e6cab7.akpm@osdl.org>
	 <Pine.LNX.4.58.0503160853360.11824@localhost.localdomain>
	 <Pine.LNX.4.58.0503161141001.14087@localhost.localdomain>
	 <Pine.LNX.4.58.0503161234350.14460@localhost.localdomain>
	 <1111000818.21369.8.camel@mindpipe>
	 <Pine.LNX.4.58.0503170210530.17019@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 10:41:22 -0500
Message-Id: <1111074082.23171.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 02:15 -0500, Steven Rostedt wrote:
> 
> On Wed, 16 Mar 2005, Lee Revell wrote:
> 
> > I am a bit confused, big surprise.  Does this thread still have anything
> > to do with this trace from my "Latency regressions" bug report?
> 
> Don't worry, I've been in a state of confusion for a long time now ;-)
> 
> >
> > http://www.alsa-project.org/~rlrevell/2912us
> >
> > The problem only is apparent with PREEMPT_DESKTOP and "data=ordered".
> >
> > PREEMPT_RT has always worked perfectly.
> >
> 
> I'm surprise that PREEMPT_RT does work.  I'm no longer sure that this does
> affect your latency anymore.  It probably does indirectly somehow.  I
> still think it has to do with the bitspinlocks.  But I'm not sure. Just
> let me know if you want to be taken off this thread and I'll remove you
> from my CC list.  Until then, I'll keep you on.

Sorry, it's hard to follow this thread.  Just to make sure we're all on
the same page, what exactly is the symptom of this ext3 issue you are
working on?  Is it a performance regression, or a latency issue, or a
lockup - ?

Whatever your problem is, I am not seeing it.

Lee

