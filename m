Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVCQQgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVCQQgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 11:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVCQQgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 11:36:48 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:7130 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262001AbVCQQgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 11:36:31 -0500
Subject: Re: [patch 0/3] j_state_lock, j_list_lock, remove-bitlocks
From: Lee Revell <rlrevell@joe-job.com>
To: rostedt@goodmis.org
Cc: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0503171108510.17696@localhost.localdomain>
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
	 <1111074082.23171.8.camel@mindpipe>
	 <Pine.LNX.4.58.0503171108510.17696@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 17 Mar 2005 11:36:22 -0500
Message-Id: <1111077383.23171.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 11:23 -0500, Steven Rostedt wrote:
> 
> On Thu, 17 Mar 2005, Lee Revell wrote:
> 
> >
> > Sorry, it's hard to follow this thread.  Just to make sure we're all on
> > the same page, what exactly is the symptom of this ext3 issue you are
> > working on?  Is it a performance regression, or a latency issue, or a
> > lockup - ?
> >
> > Whatever your problem is, I am not seeing it.
> >
> 
> The root is a lockup.  I think you can get this lockup whether or not it
> is PREEMPT_RT or PREEPMT_DESKTOP.  All you need is CONFIG_PREEMPT turned
> on. Then this is what you want to do on a UP Machine.

OK, no need to cc: me on this one any more.  It's really low priority
IMO compared to the big latencies I am seeing with ext3 and
"data=ordered".  Unless you think there is any relation.

Lee

