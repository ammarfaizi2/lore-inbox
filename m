Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267353AbUJRU6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267353AbUJRU6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 16:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267352AbUJRU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 16:58:38 -0400
Received: from brown.brainfood.com ([146.82.138.61]:44928 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267360AbUJRU63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 16:58:29 -0400
Date: Mon, 18 Oct 2004 15:58:22 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
In-Reply-To: <20041018181826.GC2899@elte.hu>
Message-ID: <Pine.LNX.4.58.0410181557190.1218@gradall.private.brainfood.com>
References: <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
 <20041018145008.GA25707@elte.hu> <Pine.LNX.4.58.0410181249150.1218@gradall.private.brainfood.com>
 <20041018181826.GC2899@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Ingo Molnar wrote:

> > However, after I reset the threshold to 50(and got a few small traces), I got
> > this whopper.
> >
> > (XFree86/1129/CPU#0): new 4692 us maximum-latency critical section.
> >  => started at timestamp 358506933: <call_console_drivers+0x76/0x140>
> >  =>   ended at timestamp 358511625: <finish_task_switch+0x43/0xa0>
> >  [<c0132480>] sub_preempt_count+0x60/0x90
>
> interesting - this could be a printk (trace) done in a critical section
> though. What does /proc/latency_trace tell, is it full of console code
> functions?

Too late, it's gone.  It'd be nice if there was some way to have history on
that file.
