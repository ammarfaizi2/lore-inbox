Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVJRBbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVJRBbB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 21:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVJRBbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 21:31:01 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:1178 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S932375AbVJRBbA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 21:31:00 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, cc@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <1129576885.4720.3.camel@cmn3.stanford.edu>
References: <20051017160536.GA2107@elte.hu>
	 <1129576885.4720.3.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 18:30:29 -0700
Message-Id: <1129599029.10429.1.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 12:21 -0700, Fernando Lopez-Lezcano wrote:
> On Mon, 2005-10-17 at 18:05 +0200, Ingo Molnar wrote:
> > i have released the 2.6.14-rc4-rt7 tree, which can be downloaded from 
> > the usual place:
> > 
> >   http://redhat.com/~mingo/realtime-preempt/
> > 
> > the biggest change is the merging of "ktimers next step", a'ka the 
> > clockevents framework, from Thomas Gleixner. This is mostly a design 
> > cleanup of the existing timekeeping, timer and HRT codebase. One 
> > user-visible aspect is that the PIT timer is now available as a hres 
> > source too - APIC-less systems will find this useful.
> 
> Some feedback. It looks like the issues I was having are gone, no weird
> key repeats or screensaver activations __plus__ no problems so far with
> spurious warnings from Jack! Woohooo!!! (of course it may be that I
> start getting them as soon as I press send)

It took some time but I got a couple of instances of keys repeating too
fast (it happened 3 or 4 times). Regretfully no BUG messages
in /var/log/messages this time...

-- Fernando


