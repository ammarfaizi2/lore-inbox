Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754642AbWKHSXV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbWKHSXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754636AbWKHSXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:23:21 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:27620 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1754642AbWKHSXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:23:20 -0500
Date: Wed, 8 Nov 2006 23:53:19 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, akpm@osdl.org, mbligh@google.com,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com
Subject: Re: [RFC] cpuset:  Explicit dynamic sched domain cpuset flag
Message-ID: <20061108182319.GA7924@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061030212615.GA10567@in.ibm.com> <20061030212922.GA20369@in.ibm.com> <20061031064300.10a97c13.pj@sgi.com> <20061108023836.0f3bbd18.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061108023836.0f3bbd18.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 02:38:36AM -0800, Paul Jackson wrote:
> Dinakar,
> 
> Where do we stand on this patch?
> 
> Last I knew, as of a week ago:
> 
>   * I had (still have) a patch in *-mm to nuke the old connection
>     between the cpu_exclusive flag and sched domain partitioning:
> 	cpuset-remove-sched-domain-hooks-from-cpusets.patch
>   * and you have this patch posted on lkml, with some non-trivial
>     comments from myself, to provide a new 'sched_domain' per-cpuset
>     flag to control sched domain partitioning.
> 
> Ideally, we'd agree on this new 'sched_domain' (or whatever we call it)
> flag, so that my patch to remove the old hooks could travel to 2.6.20
> along with this present patch to provide new and improved hooks.
> 
> However ... I need to focus on some other stuff for roughly four
> weeks, so can't focus on pushing this effort along right now.
> 
> My guess is that I will end up asking Andrew to hold the above
> named "remove ... hooks" patch in *-mm until you and I get our
> act together on the replacement, which most likely will mean he
> holds it until we start work on what will become 2.6.21.
> 
> Do you see any better choices?

Paul, I got busy on my end too and hope to work on it next week.
I guess I'll work on it with your suggestions and post it as soon
as I can. You can take a look at them when you are free.
Thank you for the patience

	-Dinakar
