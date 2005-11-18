Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVKRWIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVKRWIR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 17:08:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVKRWIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 17:08:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:36316 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751026AbVKRWIP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 17:08:15 -0500
Date: Fri, 18 Nov 2005 23:07:55 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       "Paul E. McKenney" <paulmck@us.ibm.com>, "K.R. Foley" <kr@cybsft.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051118220755.GA3029@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132336954.20672.11.camel@cmn3.stanford.edu> <1132350882.6874.23.camel@mindpipe> <1132351533.4735.37.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132351533.4735.37.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> Arghhh, at least I take this as a confirmation that the TSCs do drift 
> and there is no workaround. It currently makes the -rt/Jack 
> combination not very useful, at least in my tests.
> 
> Is there a way to resync the TSCs?

no reasonable way. Does idle=poll make any difference?

	Ingo
