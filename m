Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVHBPs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVHBPs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVHBPqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 11:46:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:36233 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261575AbVHBPqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 11:46:24 -0400
Subject: Re: 2.6.13-rc3 -> sluggish PS2 keyboard (was Re: [patch] Real-Time
	Preemption, -RT-2.6.13-rc4-V0.7.52-01)
From: Lee Revell <rlrevell@joe-job.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050802154404.GA13101@ucw.cz>
References: <20050730160345.GA3584@elte.hu> <1122756435.29704.2.camel@twins>
	 <20050730205259.GA24542@elte.hu> <1122785233.10275.3.camel@mindpipe>
	 <20050731063852.GA611@elte.hu> <1122871521.15825.13.camel@mindpipe>
	 <1122991018.1590.2.camel@localhost.localdomain>
	 <1122991531.5490.27.camel@mindpipe>
	 <1122992426.1590.11.camel@localhost.localdomain>
	 <1122997061.11253.3.camel@mindpipe>  <20050802154404.GA13101@ucw.cz>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 11:46:18 -0400
Message-Id: <1122997579.11253.12.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-02 at 17:44 +0200, Vojtech Pavlik wrote:
> Is your keyboard interrupt (irq #1) working correctly? If not, then the
> keyboard controller is polled at 20Hz to compensate for lost interrupts,
> which would make it work, but if no interrupts work, it would seem like
> typing over a slow link.
> 

Bingo, no interrupts when I type.

What could cause this?  I was switching machines so I unplugged this
keyboard a few times since booting.

Lee

