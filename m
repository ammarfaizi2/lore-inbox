Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266914AbUJRRIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266914AbUJRRIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 13:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUJRRIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 13:08:12 -0400
Received: from brown.brainfood.com ([146.82.138.61]:40068 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S266914AbUJRRIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 13:08:11 -0400
Date: Mon, 18 Oct 2004 12:08:09 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U5
In-Reply-To: <20041018145008.GA25707@elte.hu>
Message-ID: <Pine.LNX.4.58.0410181207000.1223@gradall.private.brainfood.com>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu>
 <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
 <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu>
 <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu>
 <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu>
 <20041018145008.GA25707@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U5 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U5
>
> this is a release intended to increase stability, but since it also
> includes new debug features and related cleanups it might introduce new
> regressions. Be careful.
>
> [snip]
>
>  - debug feature: implemented /proc/sys/kernel/trace_verbose runtime
>    flag (default:0), which enables a much more verbose printout in
>    /proc/latency_trace.  This trace format can be useful in e.g.
>    debugging timestamp weirdnesses.
>

With all these proc values, what do you recommend they should be set to?
