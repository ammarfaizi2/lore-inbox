Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVIGSSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVIGSSx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVIGSSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:18:53 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:26054 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932184AbVIGSSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:18:52 -0400
Date: Wed, 7 Sep 2005 23:48:23 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050907181823.GF28387@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200509031814.49666.kernel@kolivas.org> <20050904201054.GA4495@us.ibm.com> <20050904212616.B11265@flint.arm.linux.org.uk> <20050905053225.GA4294@in.ibm.com> <20050905054813.GC25856@us.ibm.com> <20050905063229.GB4294@in.ibm.com> <431F11FF.2000704@tmr.com> <29495f1d0509070942688059a6@mail.gmail.com> <20050907171756.GB28387@in.ibm.com> <29495f1d05090710276d64a3de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29495f1d05090710276d64a3de@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2005 at 10:27:43AM -0700, Nish Aravamudan wrote:
> enter_all_cpus_idle() and exit_all_cpus_idle() would be better?

Looks perfect.

> No, I was saying what you were, if a little unclearly, so the caller
> does something like:
> 
> current_dyn_tick_timer->reprogram();
> check_cpu_mask(nohz_cpu_mask);
> if (we_are_last_idle)
>   enter_all_cpus_idle();

Looks fine!

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
