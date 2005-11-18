Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbVKRWmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbVKRWmF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKRWmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:42:05 -0500
Received: from smtp2.Stanford.EDU ([171.67.16.125]:2014 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932119AbVKRWmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:42:04 -0500
Subject: Re: 2.6.14-rt13
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
In-Reply-To: <20051118220755.GA3029@elte.hu>
References: <20051115090827.GA20411@elte.hu>
	 <1132336954.20672.11.camel@cmn3.stanford.edu>
	 <1132350882.6874.23.camel@mindpipe>
	 <1132351533.4735.37.camel@cmn3.stanford.edu>
	 <20051118220755.GA3029@elte.hu>
Content-Type: text/plain
Date: Fri, 18 Nov 2005 14:41:29 -0800
Message-Id: <1132353689.4735.43.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-18 at 23:07 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > Arghhh, at least I take this as a confirmation that the TSCs do drift 
> > and there is no workaround. It currently makes the -rt/Jack 
> > combination not very useful, at least in my tests.
> > 
> > Is there a way to resync the TSCs?
> 
> no reasonable way. Does idle=poll make any difference?

I don't know yet, and I may never know :-) I've been running it for a
while and so far works but that's what I thought yesterday of -rt13. It
is not practical for normal use, it just heats the cpu unnecessarily and
there's no way to control it other than a reboot. I'll keep my machine
running like this till I go home later. 

-- Fernando


