Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267770AbUJSRbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267770AbUJSRbR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 13:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUJSR2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 13:28:33 -0400
Received: from brown.brainfood.com ([146.82.138.61]:3968 "EHLO
	gradall.private.brainfood.com") by vger.kernel.org with ESMTP
	id S267770AbUJSRWu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:22:50 -0400
Date: Tue, 19 Oct 2004 12:22:48 -0500 (CDT)
From: Adam Heath <doogie@debian.org>
X-X-Sender: adam@gradall.private.brainfood.com
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U6
In-Reply-To: <20041019124605.GA28896@elte.hu>
Message-ID: <Pine.LNX.4.58.0410191222050.1216@gradall.private.brainfood.com>
References: <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu>
 <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>
 <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>
 <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>
 <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>
 <20041019124605.GA28896@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004, Ingo Molnar wrote:

>
> i have released the -U6 Real-Time Preemption patch:
>
>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U6
>
> this is a fixes-only release.
>
> found and fixed the 'big bug' that was probably the one causing
> stability problems for a number of people. There was a small window for
> a task double-free race to occur, causing all sorts of crashes later on.
> This bug could trigger on UP and SMP systems alike, on SMP being a bit
> more frequent.

I am still having the same bug(repeatable by running liquidwar) as I reported
with -U5(see my earlier email).
