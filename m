Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUKHWCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUKHWCM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 17:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUKHWCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 17:02:12 -0500
Received: from gizmo09ps.bigpond.com ([144.140.71.19]:8172 "HELO
	gizmo09ps.bigpond.com") by vger.kernel.org with SMTP
	id S261258AbUKHWBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 17:01:55 -0500
Message-ID: <418FECCF.1060609@bigpond.net.au>
Date: Tue, 09 Nov 2004 09:01:51 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
CC: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] Plugsched for 2.6.10-rc1-mm3
References: <418DB67D.2000903@kolivas.org>
In-Reply-To: <418DB67D.2000903@kolivas.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> While mainline seems uninterested in pluggable cpu schedulers, it seems 
> the demand and response off-list has been rather large so I'll continue 
> to develop it.
> 
> http://ck.kolivas.org/patches/plugsched/2.6.10-rc1-mm3/
> 
> has a patch tarball and a rolled up patch for applying the current 
> plugsched infrastructure.
> 
> 
> Changes:
> Rolled up the bugfixes into their respective parent patches.
> Added an optional private set_task_cpu.
> Privatised get_idle for kgdb.
> Privatised normalise rt sysrq.
> Updated staircase cpu scheduler.
> 
> 
> Planned:
> More shared code between schedulers.
> Sysfs tunables.
> 
> 
> Note that mm3 has some vm bugs leading to compile problems and 
> instability that you'd need to add on if you wish to try these patches.

A port of the Zaphod scheduler as a plugsched module for the 0411071616 
version of plugsched for the 2.6.10-rc1-mm3 kernel is available at:

<http://prdownloads.sourceforge.net/cpuse/2.6.10-rc1-mm3-plugsched-0411071616-zaphod-v0.1.diff?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
