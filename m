Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268213AbUJHSVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268213AbUJHSVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270080AbUJHSUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 14:20:43 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:60857 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268213AbUJHSF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 14:05:28 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm3-T3
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <lkml@kolivas.org>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>, Florian Schmidt <mista.tapas@gmx.net>,
       mark_h_johnson@raytheon.com,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>
In-Reply-To: <4166386F.7050504@kolivas.org>
References: <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
	 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
	 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
	 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
	 <20041004215315.GA17707@elte.hu> <20041005134707.GA32033@elte.hu>
	 <20041007105230.GA17411@elte.hu>
	 <56697.195.245.190.93.1097157219.squirrel@195.245.190.93>
	 <32798.192.168.1.5.1097191570.squirrel@192.168.1.5>
	 <1097213813.1442.2.camel@krustophenia.net>  <4166386F.7050504@kolivas.org>
Content-Type: text/plain
Message-Id: <1097258722.1442.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 08 Oct 2004 14:05:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-08 at 02:49, Con Kolivas wrote:
> Lee Revell wrote:
> > On Thu, 2004-10-07 at 19:26, Rui Nuno Capela wrote:
> > 
> >>Ingo Molnar wrote:
> >>
> >>>>i've released the -T3 VP patch:
> >>>>  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm3-T3
> >>>>
> >>>
> >>OK. Just to let you know, both of my personal machines are now running on
> >>bleeding-edge 2.6.9-rc3-mm3-T3, and very happily may I assure :)
> > 
> > 
> > This actually feels a _lot_ snappier than mm2, which seemed prone to
> > weird stalls.  I don't have any numbers to back this up yet.
> 
> mm2 had a completely different cpu scheduler so no meaningful comparison 
> can be made. Try comparing to mm3 vanilla.

Well, I figured the change from -mm2 to -mm3 was responsible, as I have
never seen the VP patches make a perceptible difference in system
response time.  The VP effect only becomes apparent when you do
something that really needs millisecond or sub-ms latency.  I guess a
bug in the VP patch could cause performance regressions though.  However
no one reported sluggishness with mm2+S7, but it's apparent when you try
mm3+T3 that it feels a lot more responsive.

Anyway I was just wondering if there was an obvious change that would
cause this.

Lee

