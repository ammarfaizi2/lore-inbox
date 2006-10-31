Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423388AbWJaObr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423388AbWJaObr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 09:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423392AbWJaObr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 09:31:47 -0500
Received: from ns.suse.de ([195.135.220.2]:45011 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1423388AbWJaObp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 09:31:45 -0500
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: 2.6.19-rc3: more DWARFs and strange messages
References: <20061028200151.GC5619@gimli>
From: Andi Kleen <ak@suse.de>
Date: 31 Oct 2006 15:31:41 +0100
In-Reply-To: <20061028200151.GC5619@gimli>
Message-ID: <p73hcxklfoy.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz <martin@lorenz.eu.org> writes:

> and quite a few of those:
> 
> [18504.980000] BUG: warning at kernel/cpu.c:56/unlock_cpu_hotplug()
> [18504.980000]  [<c0103bdd>] dump_trace+0x69/0x1af
> [18504.980000]  [<c0103d3b>] show_trace_log_lvl+0x18/0x2c
> [18504.980000]  [<c01043da>] show_trace+0xf/0x11
> [18504.980000]  [<c01044dd>] dump_stack+0x15/0x17
> [18504.980000]  [<c0135e94>] unlock_cpu_hotplug+0x3d/0x66
> [18504.980000]  [<f92e67f3>] do_dbs_timer+0x1c2/0x229 [cpufreq_ondemand]
> [18504.980000]  [<c012ccb1>] run_workqueue+0x83/0xc5
> [18504.980000]  [<c012d5d5>] worker_thread+0xd9/0x10c
> [18504.980000]  [<c012fb36>] kthread+0xc2/0xf0
> [18504.980000]  [<c010398b>] kernel_thread_helper+0x7/0x10
> [18504.980000] DWARF2 unwinder stuck at kernel_thread_helper+0x7/0x10

What gcc / binutils version do you use?

> [18504.980000]
> [18504.980000] Leftover inexact backtrace:
> [18504.980000]
> [18504.980000]  =======================
> 

-Andi
