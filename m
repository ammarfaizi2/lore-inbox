Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVHBP5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVHBP5g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVHBPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:55:07 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:42473 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261599AbVHBPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:53:51 -0400
Subject: Re: 2.6.13-rc3 -> sluggish PS2 keyboard (was Re: [patch] Real-Time
	Preemption, -RT-2.6.13-rc4-V0.7.52-01)
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1122997633.11253.14.camel@mindpipe>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
	 <20050731063852.GA611@elte.hu> <1122871521.15825.13.camel@mindpipe>
	 <1122991018.1590.2.camel@localhost.localdomain>
	 <1122991531.5490.27.camel@mindpipe>
	 <1122992426.1590.11.camel@localhost.localdomain>
	 <1122997061.11253.3.camel@mindpipe>  <20050802154404.GA13101@ucw.cz>
	 <1122997633.11253.14.camel@mindpipe>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 02 Aug 2005 11:53:38 -0400
Message-Id: <1122998018.1590.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 11:47 -0400, Lee Revell wrote:
> On Tue, 2005-08-02 at 17:44 +0200, Vojtech Pavlik wrote:
> > Is your keyboard interrupt (irq #1) working correctly? If not, then the
> > keyboard controller is polled at 20Hz to compensate for lost interrupts,
> > which would make it work, but if no interrupts work, it would seem like
> > typing over a slow link.
> 
> I am an idiot.  The keyboard was plugged into the mouse port.
> 
> I'm impressed this worked at all.

:)

I guess this also makes the case that my sluggish keyboard is from the X
updates in debian. I wasn't able  to get it to be sluggish at the
console, and it was only sluggish under X load.

-- Steve


