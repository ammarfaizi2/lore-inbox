Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262434AbTEVBQH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 21:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTEVBQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 21:16:07 -0400
Received: from franka.aracnet.com ([216.99.193.44]:62102 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262434AbTEVBQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 21:16:06 -0400
Date: Wed, 21 May 2003 18:28:56 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Gerrit Huizenga <gh@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>
cc: jamesclv@us.ibm.com, haveblue@us.ibm.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mannthey@us.ibm.com
Subject: Re: userspace irq balancer 
Message-ID: <58830000.1053566935@[10.10.2.4]>
In-Reply-To: <E19Idxq-0001LD-00@w-gerrit2>
References: <E19Idxq-0001LD-00@w-gerrit2>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, I suppose this userland policy change means we should pull
> the scheduler policy decisions out of the kernel and write user level
> HT, NUMA, SMP and UP schedulers.  Also, the IO schedulers should
> probably be pulled out - I'm sure AS and CFQ and linus_scheduler
> could be user land policies, as well as the elevator.  Memory
> placement and swapping policies, too.
> 
> Oh, wait, some people actually do this - they call it, what,
> Workload Management or some such thing.  But I don't know any
> style of workload management that leaves *no* default, semi-sane
> policy in the kernel.

I think the word you're groping for here is "microkernel".

M.

