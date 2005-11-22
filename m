Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVKVLTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVKVLTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVKVLTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:19:54 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:20414 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964920AbVKVLTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:19:53 -0500
Date: Tue, 22 Nov 2005 12:19:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "K.R. Foley" <kr@cybsft.com>, Steven Rostedt <rostedt@goodmis.org>,
       Thomas Gleixner <tglx@linutronix.de>, pluto@agmk.net,
       john cooper <john.cooper@timesys.com>,
       Benedikt Spranger <bene@linutronix.de>,
       Daniel Walker <dwalker@mvista.com>,
       Tom Rini <trini@kernel.crashing.org>,
       George Anzinger <george@mvista.com>
Subject: Re: 2.6.14-rt13
Message-ID: <20051122111943.GB948@elte.hu>
References: <20051115090827.GA20411@elte.hu> <1132608728.4805.20.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132608728.4805.20.camel@cmn3.stanford.edu>
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

> I just had a short burst of key repeats and saw one random screen 
> blank. Right now everything seems normal but I was not allucinating 
> :-)

btw., today i have experienced a 'key repeat' event with the stock FC4 
SMP kernel too, on an X2 athlon. That kernel didnt have idle=poll 
specified, so gettimeofday() could time-warp in substantial ways.

so i'd say the 'key repeat' problem is almost certainly caused by TSC 
"time warps" on X2's.

	Ingo
