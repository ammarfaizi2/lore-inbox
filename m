Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268648AbUIXJaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268648AbUIXJaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 05:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268646AbUIXJaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 05:30:46 -0400
Received: from holomorphy.com ([207.189.100.168]:37342 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268648AbUIXJag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 05:30:36 -0400
Date: Fri, 24 Sep 2004 02:30:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
Message-ID: <20040924093006.GY9106@holomorphy.com>
References: <20040924014643.484470b1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924014643.484470b1.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 01:46:43AM -0700, Andrew Morton wrote:
> - This is a quick not-very-well-tested release - it can't be worse than
>   2.6.9-rc2-mm2, which had a few networking problems.
> - Added Dmitry Torokhov's input system tree to the -mm bk tree lineup.
> +512x-altix-timer-interrupt-livelock-fix-vs-269-rc2-mm2.patch
>  profiler speedup

Hmm, it's more that the profiler failed to meet a hard RT deadline
(yes, Linux has some of those) i.e. finishing its work before the next
timer interrupt occurs. I suppose a speedup is the nature of the fix...


On Fri, Sep 24, 2004 at 01:46:43AM -0700, Andrew Morton wrote:
> +sparc32-early-tick_ops.patch
>  Avoid early oops on sparc32 with the zaphod scheduler

This is probably sparc64; I've not been doing much with -mm on sparc32
apart from compiletests in favor of chasing longer-term issues e.g.
HyperSPARC DMA, SMP, etc., largely using mainline point releases.


-- wli
