Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWBKCBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWBKCBI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 21:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWBKCBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 21:01:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750872AbWBKCBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 21:01:06 -0500
Date: Fri, 10 Feb 2006 18:00:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: suresh.b.siddha@intel.com, kernel@kolivas.org, npiggin@suse.de,
       mingo@elte.hu, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-Id: <20060210180010.16c9d20a.akpm@osdl.org>
In-Reply-To: <43ED3D6A.8010300@bigpond.net.au>
References: <20060207142828.GA20930@wotan.suse.de>
	<200602080157.07823.kernel@kolivas.org>
	<20060207141525.19d2b1be.akpm@osdl.org>
	<200602081011.09749.kernel@kolivas.org>
	<20060207153617.6520f126.akpm@osdl.org>
	<20060209230145.A17405@unix-os.sc.intel.com>
	<20060209231703.4bd796bf.akpm@osdl.org>
	<43ED3D6A.8010300@bigpond.net.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams <pwil3058@bigpond.net.au> wrote:
>
> I don't think either of these issues warrant abandoning smpnice.  The 
>  first is highly unlikely to occur on real systems and the second is just 
>  an example of the patch doing its job (maybe too officiously).  I don't 
>  think users would notice either on real systems.
> 
>  Even if you pull it from 2.6.16 rather than upgrading it with my patch 
>  can you please leave both in -mm?

Yes, I have done that.  I currently have:

sched-restore-smpnice.patch
sched-modified-nice-support-for-smp-load-balancing.patch
sched-cleanup_task_activated.patch
sched-alter_uninterruptible_sleep_interactivity.patch
sched-make_task_noninteractive_use_sleep_type.patch
sched-dont_decrease_idle_sleep_avg.patch
sched-include_noninteractive_sleep_in_idle_detect.patch
sched-new-sched-domain-for-representing-multi-core.patch
sched-fix-group-power-for-allnodes_domains.patch

