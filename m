Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263625AbUJ2Vwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263625AbUJ2Vwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUJ2VuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:50:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:56472 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263626AbUJ2Vmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:42:52 -0400
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20041029212545.GA13199@elte.hu>
References: <20041029163155.GA9005@elte.hu>
	 <20041029191652.1e480e2d@mango.fruits.de> <20041029170237.GA12374@elte.hu>
	 <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de>
	 <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu>
	 <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu>
	 <20041029233117.6d29c383@mango.fruits.de>  <20041029212545.GA13199@elte.hu>
Content-Type: text/plain
Date: Fri, 29 Oct 2004 17:42:45 -0400
Message-Id: <1099086166.1468.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 23:25 +0200, Ingo Molnar wrote:
> > will do so. btw: i think i'm a bit confused right now. What debugging
> > features should i have enabled for this test?
> 
> this particular one (atomicity-checking) is always-enabled if you have
> the -RT patch applied (it's a really cheap check).

One more question, what do you recommend the priorities of the IRQ
threads be set to?  AIUI for xrun-free operation with JACK, all that is
needed is to set the RT priorities of the soundcard IRQ thread highest,
followed by the JACK threads, then the other IRQ threads.  Is this
correct?

Lee  

