Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVHBOJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVHBOJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 10:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVHBOHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 10:07:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:12265 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261530AbVHBOFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 10:05:32 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122991018.1590.2.camel@localhost.localdomain>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
	 <20050731063852.GA611@elte.hu>  <1122871521.15825.13.camel@mindpipe>
	 <1122991018.1590.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 10:05:30 -0400
Message-Id: <1122991531.5490.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 09:56 -0400, Steven Rostedt wrote:
> On Mon, 2005-08-01 at 00:45 -0400, Lee Revell wrote:
> > On Sun, 2005-07-31 at 08:38 +0200, Ingo Molnar wrote:
> > > ok - i've uploaded the -52-04 patch, does that fix it for you?
> > 
> > Has anyone found their PS2 keyboard rather sluggish with this kernel?
> > I'm not sure whether it's an -RT problem, I'll have to try rc4.
> 
> I've just noticed this now. While I have lots of ssh sessions running,
> my keyboard does get really sluggish. This hasn't happened before. I'm
> currently running 2.6.13-rc3 with no RT.  So this may definitely be a
> mainline issue.

I'm on a slower machine, and I seem to get this behavior regardless of
load.  Probably just running X+Gnome on this box is enough.

Are you in any position to do a binary search?  It would be really bad
to release 2.6.13 with this problem...

Lee

