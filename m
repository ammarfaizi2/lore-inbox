Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbVHBQXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVHBQXa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 12:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVHBP5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:57:44 -0400
Received: from styx.suse.cz ([82.119.242.94]:55214 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261599AbVHBPzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:55:10 -0400
Date: Tue, 2 Aug 2005 17:55:08 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.13-rc3 -> sluggish PS2 keyboard (was Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01)
Message-ID: <20050802155508.GA13250@ucw.cz>
References: <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe> <20050731063852.GA611@elte.hu> <1122871521.15825.13.camel@mindpipe> <1122991018.1590.2.camel@localhost.localdomain> <1122991531.5490.27.camel@mindpipe> <1122992426.1590.11.camel@localhost.localdomain> <1122997061.11253.3.camel@mindpipe> <20050802154404.GA13101@ucw.cz> <1122997633.11253.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122997633.11253.14.camel@mindpipe>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 11:47:13AM -0400, Lee Revell wrote:

> On Tue, 2005-08-02 at 17:44 +0200, Vojtech Pavlik wrote:
> > Is your keyboard interrupt (irq #1) working correctly? If not, then the
> > keyboard controller is polled at 20Hz to compensate for lost interrupts,
> > which would make it work, but if no interrupts work, it would seem like
> > typing over a slow link.
> 
> I am an idiot.  The keyboard was plugged into the mouse port.
> 
> I'm impressed this worked at all.
 
It would likely even work correctly if irq 12 was available and working
on the AUX port.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
