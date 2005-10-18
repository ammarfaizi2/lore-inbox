Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVJRVE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVJRVE7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 17:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbVJRVE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 17:04:59 -0400
Received: from smtp1.Stanford.EDU ([171.67.16.123]:48007 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932140AbVJRVE7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 17:04:59 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051018072844.GB21915@elte.hu>
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
	 <1129599029.10429.1.camel@cmn3.stanford.edu>
	 <20051018072844.GB21915@elte.hu>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 14:04:34 -0700
Message-Id: <1129669474.5929.8.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 09:28 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > > Some feedback. It looks like the issues I was having are gone, no weird
> > > key repeats or screensaver activations __plus__ no problems so far with
> > > spurious warnings from Jack! Woohooo!!! (of course it may be that I
> > > start getting them as soon as I press send)
> > 
> > It took some time but I got a couple of instances of keys repeating 
> > too fast (it happened 3 or 4 times). Regretfully no BUG messages in 
> > /var/log/messages this time...
> 
> ok, i have uploaded the -rt8 patch, which has the ktimer debugging code 
> included again. Could you give it a try and see whether there are any 
> debugging messages happening at the same time the keys repeat?

-rt8 lead to two hard crashes (the "press the reset button" kind) this
morning, both while evolution was starting up (reading email), and the
last one lead to nfs fcntl locking issues with evo that eventually
required a server reboot. 

So I'm back at -rt6 for now...
-- Fernando


