Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269520AbUINV6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269520AbUINV6m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 17:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269582AbUINRJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 13:09:22 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:39348 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S269442AbUINQkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 12:40:10 -0400
Date: Tue, 14 Sep 2004 18:39:29 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix scheduling latencies for !PREEMPT kernels
Message-ID: <20040914163929.GR4180@dualathlon.random>
References: <20040914105904.GB31370@elte.hu> <20040914110237.GC31370@elte.hu> <20040914110611.GA32077@elte.hu> <20040914112847.GA2804@elte.hu> <20040914114228.GD2804@elte.hu> <4146EA3E.4010804@yahoo.com.au> <20040914132225.GA9310@elte.hu> <4146F33C.9030504@yahoo.com.au> <20040914140905.GM4180@dualathlon.random> <20040914163106.GS9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040914163106.GS9106@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 09:31:06AM -0700, William Lee Irwin III wrote:
> The might_sleep() in cond_resched() sounds particularly useful to pick
> up misapplications of cond_resched().

agreed ;)

> I suppose this isn't even the half of it, but it's what I looked at.

looks much nicer indeed (the previous code was basic-like ;).
