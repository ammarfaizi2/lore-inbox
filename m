Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUJLXOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUJLXOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 19:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268051AbUJLXOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 19:14:19 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:19461 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S268048AbUJLXOI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 19:14:08 -0400
Date: Tue, 12 Oct 2004 16:13:33 -0700
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Bill Huey <bhuey@lnxw.com>, dwalker@mvista.com,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       amakarov@ru.mvista.com, ext-rt-dev@mvista.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Ext-rt-dev] Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
Message-ID: <20041012231333.GD30966@nietzsche.lynx.com>
References: <1097437314.17309.136.camel@dhcp153.mvista.com> <20041010142000.667ec673.akpm@osdl.org> <20041010215906.GA19497@elte.hu> <1097517191.28173.1.camel@dhcp153.mvista.com> <20041011204959.GB16366@elte.hu> <1097607049.9548.108.camel@dhcp153.mvista.com> <1097610393.19549.69.camel@thomas> <20041012211201.GA28590@nietzsche.lynx.com> <20041012212408.GA28707@nietzsche.lynx.com> <1097616738.19549.160.camel@thomas>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097616738.19549.160.camel@thomas>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 11:32:18PM +0200, Thomas Gleixner wrote:
> You missed the point. TYPE decides whether to toggle interrupts or not.
> It's a generic function equivivalent, which identifies sections of code,
> which must be protected. The grade of protection is defined in TYPE.

Sorry, I misunderstood out of my impulsiveness. If I understand you,
you just want a gradual method of determining which critical sections
need to be preemptive or not depending if you need a server or RT
performance ?

I thought you were talking about something else if this is the case.

bill

