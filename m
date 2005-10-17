Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbVJQTVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbVJQTVp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVJQTVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:21:45 -0400
Received: from smtp3.Stanford.EDU ([171.67.16.138]:995 "EHLO
	smtp3.Stanford.EDU") by vger.kernel.org with ESMTP id S1751046AbVJQTVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:21:44 -0400
Subject: Re: 2.6.14-rc4-rt7
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: cc@ccrma.Stanford.EDU, nando@ccrma.Stanford.EDU,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       david singleton <dsingleton@mvista.com>,
       Steven Rostedt <rostedt@goodmis.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Knecht <markknecht@gmail.com>
In-Reply-To: <20051017160536.GA2107@elte.hu>
References: <20051017160536.GA2107@elte.hu>
Content-Type: text/plain
Date: Mon, 17 Oct 2005 12:21:25 -0700
Message-Id: <1129576885.4720.3.camel@cmn3.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-17 at 18:05 +0200, Ingo Molnar wrote:
> i have released the 2.6.14-rc4-rt7 tree, which can be downloaded from 
> the usual place:
> 
>   http://redhat.com/~mingo/realtime-preempt/
> 
> the biggest change is the merging of "ktimers next step", a'ka the 
> clockevents framework, from Thomas Gleixner. This is mostly a design 
> cleanup of the existing timekeeping, timer and HRT codebase. One 
> user-visible aspect is that the PIT timer is now available as a hres 
> source too - APIC-less systems will find this useful.

Some feedback. It looks like the issues I was having are gone, no weird
key repeats or screensaver activations __plus__ no problems so far with
spurious warnings from Jack! Woohooo!!! (of course it may be that I
start getting them as soon as I press send)

[BTW, I'm running now with PREEMPT_RT as well].
Thanks!!
-- Fernando


