Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUHSJSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUHSJSJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 05:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHSJRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 05:17:15 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:30848 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264346AbUHSJO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 05:14:58 -0400
Date: Thu, 19 Aug 2004 14:42:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040819091216.GA9492@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040819014204.2d412e9b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819014204.2d412e9b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 01:42:04AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8.1/2.6.8.1-mm2/
> 
> +reiser4-rcu-barrier.patch
> +reiser4-rcu-barrier-fix.patch

The rcu-barrier patch was written long ago and pre-cpu-hotplug. 
rcu_barrier needs lock_cpu_hotplug()/unlock_cpu_hotplug(). I had
put a comment in there identifying the place.

Thanks
Dipankar
