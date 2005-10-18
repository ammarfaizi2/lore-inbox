Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVJRGyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVJRGyV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 02:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbVJRGyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 02:54:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:41357 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751447AbVJRGyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 02:54:20 -0400
Date: Tue, 18 Oct 2005 08:54:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: cc@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.14-rc4-rt7
Message-ID: <20051018065439.GA21915@elte.hu>
References: <20051017160536.GA2107@elte.hu> <1129576885.4720.3.camel@cmn3.stanford.edu> <1129599029.10429.1.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129599029.10429.1.camel@cmn3.stanford.edu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> > Some feedback. It looks like the issues I was having are gone, no weird
> > key repeats or screensaver activations __plus__ no problems so far with
> > spurious warnings from Jack! Woohooo!!! (of course it may be that I
> > start getting them as soon as I press send)
> 
> It took some time but I got a couple of instances of keys repeating 
> too fast (it happened 3 or 4 times). Regretfully no BUG messages in 
> /var/log/messages this time...

yeah, those warning messages got zapped during the merge to the latest 
ktimers/clockevents code. Will re-add them.

	Ingo
