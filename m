Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbUCCVdS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUCCVdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:33:18 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:16266 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261151AbUCCVdR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:33:17 -0500
Message-ID: <40465042.2080405@tmr.com>
Date: Wed, 03 Mar 2004 16:38:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
References: <1vuMd-5jx-5@gated-at.bofh.it> <1vuMd-5jx-7@gated-at.bofh.it> <1vuMd-5jx-9@gated-at.bofh.it> <1vuMd-5jx-11@gated-at.bofh.it> <1vuMd-5jx-3@gated-at.bofh.it> <1vvyx-6jy-13@gated-at.bofh.it> <1vBE2-48V-21@gated-at.bofh.it>
In-Reply-To: <1vBE2-48V-21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> No doubt that there are different settings that make sense 
> for different workloads. But there is no reason one has to recompile
> to set them - it's much nicer to just run a script at boot time to set
> them, instead of recompiling/rebooting. This will also make benchmarking
> much easier, because you can just write a script that sets the
> various parameters, runs workloads, sets other parameters, runs
> workload again etc. Requiring a recompile and reboot makes this
> much harder.

Andi, if people are trying to find an optimal tuning then in many cases 
a reboot is out. There are two reasons for this:
- a production server, can't just reboot!
- it's sometimes hard to recreate the load which is causing problems,
   and far easier to get a working config by diddling and watching.

At least those are the reasons why I would feel able to tune the 
machines which most need it.
