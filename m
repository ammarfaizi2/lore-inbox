Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbTCRJOm>; Tue, 18 Mar 2003 04:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262364AbTCRJOm>; Tue, 18 Mar 2003 04:14:42 -0500
Received: from holomorphy.com ([66.224.33.161]:62941 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262360AbTCRJOl>;
	Tue, 18 Mar 2003 04:14:41 -0500
Date: Tue, 18 Mar 2003 01:25:05 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030318092505.GW20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20030316213516.GM20188@holomorphy.com> <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain> <20030317070334.GO20188@holomorphy.com> <3E761124.8060402@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E761124.8060402@colorfullife.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> The NMI oopses are mostly decoded by hand b/c in-kernel (and other)
>> backtrace decoders can't do it automatically. I might have to generate
>> some fresh data, with some kind of hack (e.g. hand-coded NMI-based kind
>> of smp_call_function) to trace the culprit and not just the victim.
>> The victims were usually stuck in fork() or exit().

On Mon, Mar 17, 2003 at 07:17:08PM +0100, Manfred Spraul wrote:
> Could you check if the attached test app triggers the NMI oopser?

Okay, good news is I take NMI's now, bad news is the watchdog is still
getting disabled somehow.


-- wli
