Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263179AbTEINyz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 09:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTEINyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 09:54:55 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:41704 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263179AbTEINyy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 09:54:54 -0400
Date: Fri, 9 May 2003 19:40:12 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-ID: <20030509141012.GD2059@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030508013958.157b27b7.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508013958.157b27b7.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 08, 2003 at 08:41:12AM +0000, Andrew Morton wrote:
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.69-mm3.gz
> 
>   Will appear sometime at
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69-mm3/
> 
> 
> Small things.  Mainly a resync for various people...
> 
> rcu-stats.patch
>   RCU statistics reporting

I am wondering what we should do with this patch. The RCU stats display
the #s of RCU requests and actual updates on each CPU. On a normal system
they don't mean much to a sysadmin, so I am not sure if it is the right
thing to include this feature. OTOH, it is extremely useful to detect
potential memory leaks happening due to, say a CPU looping in
kernel (and RCU not happening consequently). Will a CONFIG_RCU_DEBUG
make it more palatable for mainline ?

Thanks
Dipankar
