Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWHPXiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWHPXiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWHPXiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:38:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:65498 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751251AbWHPXiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:38:19 -0400
Date: Wed, 16 Aug 2006 16:36:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] rcu: Mention rcu_bh in description of rcutorture's torture_type parameter
Message-ID: <20060816233641.GC1291@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1155766859.9175.37.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155766859.9175.37.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 03:20:59PM -0700, Josh Triplett wrote:
> The comment for rcutorture's torture_type parameter only lists the RCU
> variants rcu and srcu, but not rcu_bh; add rcu_bh to the list.

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index e34d22b..aff0064 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -54,7 +54,7 @@ static int stat_interval;	/* Interval be
>  static int verbose;		/* Print more debug info. */
>  static int test_no_idle_hz;	/* Test RCU's support for tickless idle CPUs. */
>  static int shuffle_interval = 5; /* Interval between shuffles (in sec)*/
> -static char *torture_type = "rcu"; /* What to torture: rcu, srcu. */
> +static char *torture_type = "rcu"; /* What to torture: rcu, rcu_bh, srcu. */
>  
>  module_param(nreaders, int, 0);
>  MODULE_PARM_DESC(nreaders, "Number of RCU reader threads");
> -- 
> 1.4.1.1
> 
> 
