Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVDCIQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVDCIQH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 04:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDCIQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 04:16:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56705 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261604AbVDCIQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 04:16:03 -0400
Date: Sun, 3 Apr 2005 00:15:20 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: kenneth.w.chen@intel.com, torvalds@osdl.org, nickpiggin@yahoo.com.au,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: auto-tune migration costs [was: Re: Industry db
 benchmark result on recent 2.6 kernels]
Message-Id: <20050403001520.4da24909.pj@engr.sgi.com>
In-Reply-To: <20050403070415.GA18893@elte.hu>
References: <200504020100.j3210fg04870@unix-os.sc.intel.com>
	<20050402145351.GA11601@elte.hu>
	<20050402215332.79ff56cc.pj@engr.sgi.com>
	<20050403070415.GA18893@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the default on ia64 (32MB) was way too large

Agreed.  It took about 9 minutes to search the first pair of cpus
(cpu 0 to cpu 1) from a size of 67107840 down to a size of 62906,
based on some prints I added since my last message.


> it seems the screen blanking timer hit

Ah - yes.  That makes sense.


> do a search from 10MB downwards. This
>   should speed up the search.

That will help (I'm guessing not enough - will see shortly.)


> verbose printouts 

I will put them to good use.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
