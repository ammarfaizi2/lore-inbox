Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUCXPLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 10:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263741AbUCXPLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 10:11:34 -0500
Received: from holomorphy.com ([207.189.100.168]:33668 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263736AbUCXPLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 10:11:33 -0500
Date: Wed, 24 Mar 2004 07:11:11 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, mjy@geizhals.at,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040324151111.GG791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takashi Iwai <tiwai@suse.de>, Andrea Arcangeli <andrea@suse.de>,
	Nick Piggin <piggin@cyberone.com.au>, Andrew Morton <akpm@osdl.org>,
	mjy@geizhals.at, linux-kernel@vger.kernel.org
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <405A584B.40601@cyberone.com.au> <20040319050948.GN2045@holomorphy.com> <20040320121423.GA9009@dualathlon.random> <20040320145111.GD2045@holomorphy.com> <20040320150311.GN9009@dualathlon.random> <s5hfzby1h6n.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hfzby1h6n.wl@alsa2.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 02:57:20PM +0100, Takashi Iwai wrote:
> 	http://www.alsa-project.org/~iwai/audio-latency.pdf
> the data there are already old (based on 2.6.0-test9), and were
> measured by the old version of latency-test program (modifed version
> from Benno Senor's latencytest suite).
> basically, the latency-test program measures the latency between the
> time of (periodical) irq and the time when user RT-thread is woken
> up under different workloads.  the user thread can perform an
> artificial CPU load (busy loop) to simulate the situation that any RT
> process does a heavy job.
> the resultant plot shows the critical deadline, the total latency and
> the CPU latency (busy loop) responses, as you can see in the above
> pdf.
> the latest version of latency-test suite is found at
> 	http://www.alsa-project.org/~iwai/latencytest-0.5.3.tar.gz
> it uses its own kernel module to generate irqs from RTC and to trace
> stacks.
> i'll show the results of the recent kernels tomorrow...

Very nice. This document is the kind of thing I wanted to see.


-- wli
