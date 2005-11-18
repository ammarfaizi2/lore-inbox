Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbVKRWP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVKRWP6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbVKRWP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:15:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6551 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750849AbVKRWP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:15:57 -0500
Subject: Re: 2.6.14-rt13
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
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
Date: Fri, 18 Nov 2005 17:15:43 -0500
Message-Id: <1132352143.6874.31.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
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

But JACK itself uses rdtsc() for timing calculations so TSC drift is
invariably fatal.

Lee

