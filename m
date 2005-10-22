Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbVJVX0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbVJVX0m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Oct 2005 19:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJVX0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Oct 2005 19:26:42 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:47532 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S1751239AbVJVX0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Oct 2005 19:26:41 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>,
       William Weston <weston@lysdexia.org>, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       nando@ccrma.Stanford.EDU, david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>
In-Reply-To: <1129957957.6385.5.camel@mindpipe>
References: <20051018072844.GB21915@elte.hu>
	 <1129669474.5929.8.camel@cmn3.stanford.edu>
	 <Pine.LNX.4.58.0510181423200.19498@echo.lysdexia.org>
	 <20051019111943.GA31410@elte.hu>
	 <1129835571.14374.11.camel@cmn3.stanford.edu>
	 <20051020191620.GA21367@elte.hu>
	 <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
	 <1129937138.5001.4.camel@cmn3.stanford.edu>
	 <5bdc1c8b0510211720q28334177p1b6d6a2cd7fbfd67@mail.gmail.com>
	 <20051022034119.GA12751@elte.hu>  <1129957957.6385.5.camel@mindpipe>
Content-Type: text/plain
Date: Sat, 22 Oct 2005 16:25:36 -0700
Message-Id: <1130023536.18750.2.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-22 at 01:12 -0400, Lee Revell wrote:
> On Sat, 2005-10-22 at 05:41 +0200, Ingo Molnar wrote:
> > high-res timers are not ported (and thus not switchable via the .config) 
> > to x64, yet - so you are much less likely to be seeing such problems.  
> > x64 does run the generic ktimer code - but this particular problem seems 
> > to be related to hres timers.
> 
> Fernando, this is somewhat OT, but are you really planning to enable
> high res timers in the ccrma kernel?  My impression so far has been that
> they are too experimental for a distro kernel.

No, I was not planning on that. In my previous bug hunt it was suggested
I turn them on and I did. Maybe it is time to try again with them off
and see if the bug(s) still show up (I was also under the impression
they were too experimental).

-- Fernando


