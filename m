Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVJVFUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVJVFUA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 01:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVJVFUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 01:20:00 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38851 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932176AbVJVFT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 01:19:59 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Mark Knecht <markknecht@gmail.com>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>,
       William Weston <weston@lysdexia.org>, cc@ccrma.stanford.edu,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <20051022034119.GA12751@elte.hu>
References: <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510211720q28334177p1b6d6a2cd7fbfd67@mail.gmail.com>
	 <20051022034119.GA12751@elte.hu>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 01:12:37 -0400
Message-Id: <1129957957.6385.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-22 at 05:41 +0200, Ingo Molnar wrote:
> high-res timers are not ported (and thus not switchable via the .config) 
> to x64, yet - so you are much less likely to be seeing such problems.  
> x64 does run the generic ktimer code - but this particular problem seems 
> to be related to hres timers.

Fernando, this is somewhat OT, but are you really planning to enable
high res timers in the ccrma kernel?  My impression so far has been that
they are too experimental for a distro kernel.

Lee

