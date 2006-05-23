Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWEWQWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWEWQWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWEWQWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:22:08 -0400
Received: from odin2.bull.net ([129.184.85.11]:57779 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1750812AbWEWQWH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:22:07 -0400
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: Daniel Walker <dwalker@mvista.com>
Subject: Re: RT patch + LTTng
Date: Tue, 23 May 2006 18:23:29 +0200
User-Agent: KMail/1.7.1
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
References: <200605221742.29566.Serge.Noiraud@bull.net> <200605231657.45363.Serge.Noiraud@bull.net> <1148397990.3535.87.camel@c-67-180-134-207.hsd1.ca.comcast.net>
In-Reply-To: <1148397990.3535.87.camel@c-67-180-134-207.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200605231823.29989.Serge.Noiraud@bull.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mardi 23 Mai 2006 17:26, Daniel Walker wrote/a écrit :
> On Tue, 2006-05-23 at 16:57 +0200, Serge Noiraud wrote:
> > mardi 23 Mai 2006 16:06, Daniel Walker wrote/a écrit :
> > > On Mon, 2006-05-22 at 17:42 +0200, Serge Noiraud wrote:
> > > 
> > > > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup (try_to_wake_up)
> > > > ltt_stat-7809  0Dnh3    0us : __trace_start_sched_wakeup <<...>-3> (0 0)
> > > 
> > > 
> > > Do you also have preempt and interrupt latency turned on ? In addition
> > > to wakeup latency ..
> > Here is all I configured :
> 
> 
> Do you get the same effect with all those options turned off?
I'll try. 

The last pb was with nmi_watchdog=1.
I get the same things with nmi_watchdog=0.

> 
> Daniel
> 
> 

-- 
Serge Noiraud 
