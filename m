Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbVKXPWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbVKXPWg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVKXPWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:22:36 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:58014 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751370AbVKXPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:22:35 -0500
Subject: Re: 2.6.14-rt13
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051124150731.GD2717@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu>
	 <1132353689.4735.43.camel@cmn3.stanford.edu>
	 <1132367947.5706.11.camel@localhost.localdomain>
	 <20051124150731.GD2717@elte.hu>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 10:21:50 -0500
Message-Id: <1132845710.6694.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-24 at 16:07 +0100, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > OK, I used this as an exercise to learn how kobject and sysfs work 
> > (I've been putting this off for too long). So if this isn't exactly 
> > proper, let me know :-)
> > 
> > Ingo, This could be a temporary patch until we come up with a better 
> > solution.  This adds /sys/kernel/idle/idle_poll, which if idle=poll is 
> > _not_ set, it still lets you switch the machine to idle=poll on the 
> > fly, as well as turn it off. If you have idle=poll, this doesn't even 
> > show up.
> 
> ok, i've applied this one too. Could you also submit it upstream (and 
> implement it for x86)? It makes sense to enable/disable the 
> polling-based idle routine runtime.

OK, it'll have to wait till tomorrow.  As you probably know, it is
Thanksgiving here in the US. And my wife would kill me if I work
today ;-)

-- Steve


