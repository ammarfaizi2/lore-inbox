Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUJPJCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUJPJCL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 05:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268688AbUJPJCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 05:02:11 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27278 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268685AbUJPJCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 05:02:08 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Daniel Walker <dwalker@mvista.com>,
       Bill Huey <bhuey@lnxw.com>, Andrew Morton <akpm@osdl.org>,
       Adam Heath <doogie@debian.org>,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Rodland <arodland@entermail.net>
In-Reply-To: <20041016064205.GA30371@elte.hu>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
	 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
	 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
	 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
	 <1097888438.6737.63.camel@krustophenia.net>
	 <1097894120.31747.1.camel@krustophenia.net>
	 <20041016064205.GA30371@elte.hu>
Content-Type: text/plain
Message-Id: <1097917325.1424.13.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 05:02:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 02:42, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > > > i have released the -U3 PREEMPT_REALTIME patch:
> > > > 
> > > >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> > > 
> > > Does not compile.  .config attached:
> > 
> > It builds fine if CONFIG_SMP is set.  Am I really the only person
> > running this on UP?
> 
> i regularly test it on UP. Do you have SPINLOCK_DEBUG enabled perhaps? 
> That doesnt work right now. You can enable DEBUG_SPINLOCK_SLEEP and
> DEBUG_PREEMPT.

Sorry, I did have that enabled.  This caused a build failure with a UP
build and a boot failure with CONFIG_SMP.

Lee

