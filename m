Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVAFRax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVAFRax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVAFRax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:30:53 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:32813
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262920AbVAFRan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:30:43 -0500
Date: Thu, 6 Jan 2005 18:30:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Richard Ems <Richard.Ems@mtg-marinetechnik.de>
Cc: linux-kernel@vger.kernel.org, Hubert Mantel <mantel@suse.de>
Subject: Re: [PROBLEM] Badness in out_of_memory
Message-ID: <20050106173052.GW4597@dualathlon.random>
References: <41DD6F67.6070303@mtg-marinetechnik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DD6F67.6070303@mtg-marinetechnik.de>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 06:03:35PM +0100, Richard Ems wrote:
> Hi list, hi Mr. Mantel,
> 
> the following "badness" happened on a SuSE 9.2 with all actual updates 
> and SuSE's kernel 2.6.8-24.10-smp.
> The system is a dual AMD Athlon MP 2200+ with 1GB memory and 1GB swap.

This is a warning only (2.6.9 had the swap token breakage that triggered
suprious oom kills, so the warning was meant to get more info), can you
try with the kernel of the day?

	http://ftp.suse.com/pub/projects/kernel/kotd/9.2-i386/SL92_BRANCH

It has my latest oom fixes that I recently posted to l-k and it should
be very reliable for the first time in oom-killer terms.
