Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWHOUWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWHOUWd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 16:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWHOUWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 16:22:32 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:30875 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750812AbWHOUWc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 16:22:32 -0400
Date: Tue, 15 Aug 2006 13:23:18 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dipkanar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH] rcu: Add MODULE_AUTHOR to rcutorture module
Message-ID: <20060815202318.GA1293@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <1155601575.5557.30.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1155601575.5557.30.camel@josh-work.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 05:26:15PM -0700, Josh Triplett wrote:

Fair enough...

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Josh Triplett <josh@freedesktop.org>
> ---
>  kernel/rcutorture.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
> index 4d1c3d2..16b5899 100644
> --- a/kernel/rcutorture.c
> +++ b/kernel/rcutorture.c
> @@ -46,6 +46,7 @@ #include <linux/byteorder/swabb.h>
>  #include <linux/stat.h>
>  
>  MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Paul E. McKenney <paulmck@us.ibm.com>");
>  
>  static int nreaders = -1;	/* # reader threads, defaults to 4*ncpus */
>  static int stat_interval;	/* Interval between stats, in seconds. */
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
