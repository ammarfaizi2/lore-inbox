Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266491AbUJIFVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266491AbUJIFVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 01:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJIFVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 01:21:05 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:65442 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266491AbUJIFVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 01:21:01 -0400
Subject: Re: voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>, Mark_H_Johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
In-Reply-To: <cone.1097298596.537768.1810.502@pc.kolivas.org>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
	 <1097297824.1442.132.camel@krustophenia.net>
	 <cone.1097298596.537768.1810.502@pc.kolivas.org>
Content-Type: text/plain
Message-Id: <1097299260.1442.142.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 01:21:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 01:09, Con Kolivas wrote:
> Lee Revell writes:
> 
> > On Thu, 2004-10-07 at 06:52, Ingo Molnar wrote:
> >> i've released the -T3 VP patch:
> >> 
> >>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> >> 
> > 
> > With VP and PREEMPT in general, does the scheduler always run the
> > highest priority process, or do we only preempt if a SCHED_FIFO process
> > is runnable?
> 
> Always the highest priority runnable.
> 

Hmm, interesting.  Would there be any advantage to a mode where only
SCHED_FIFO tasks can preempt?  This seems like a much lighter way to
solve the realtime problem.

Lee

