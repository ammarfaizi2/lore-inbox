Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbSJEBVT>; Fri, 4 Oct 2002 21:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSJEBVT>; Fri, 4 Oct 2002 21:21:19 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:28064 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261894AbSJEBVS>; Fri, 4 Oct 2002 21:21:18 -0400
Subject: Re: [OT] 2.6 not 3.0 - (NUMA)
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210041730450.2993-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0210041730450.2993-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 04 Oct 2002 18:25:45 -0700
Message-Id: <1033781147.1210.46.camel@hbaum>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2002-10-04 at 17:36, Linus Torvalds wrote:

> > Just an order of magnitude figure for you ... number of seconds spent in kernel
> > space across all CPUs during a kernel compile on a 16-way NUMA-Q ... 
> > 
> > 2.4 with every patch I had (including O(1) sched + NUMA mods) ... 120s. 
> > On 2.5.40-mm1 with one small NUMA scheduler patch ... 38s. 
> 
> Yeah, looking good..
> 
Now if we could get the "one small NUMA scheduler patch" into the
kernel...

> 		Linus
> 
> 
-- 
Michael Hohnbaum            503-578-5486
hohnbaum@us.ibm.com         T/L 775-5486

