Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDFLSa (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 07:18:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbTDFLSa (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 07:18:30 -0400
Received: from modemcable169.130-200-24.mtl.mc.videotron.ca ([24.200.130.169]:16138
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262942AbTDFLS3 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 07:18:29 -0400
Date: Sun, 6 Apr 2003 07:25:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, Robert Love <rml@tech9.net>,
       Martin Bligh <mbligh@aracnet.com>
Subject: Re: 2.5.65-preempt booting on 32way NUMAQ
In-Reply-To: <20030406112340.GM993@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0304060723400.2268-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304060625130.2268-100000@montezuma.mastecende.com>
 <20030406112340.GM993@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, William Lee Irwin III wrote:

> This has had a hard time historically. I'm really glad NUMA-Q's are now
> immune (in the sense of correctness) to this config; previously it was
> believed that preemption points in printk(linux_banner) would take out
> the machine early in boot if preemption was enabled.

Which kernel version was that from? I only recall you mentioning it.

> Congratulations rml!

Indeed =)

> If you're booting without issues on these things, you are a _very_ long
> way toward being race-free. This is incredibly good news, both for the
> preemption support, and for the general stability of the i386 bootstrap.
> 
> All that's really left is driver and non-i386 arch coverage if I'm right.

I'm going to spend a bit of time generally trying to break things, we'll 
see what comes out of it.

	Zwane
-- 
function.linuxpower.ca
