Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbSLEVRR>; Thu, 5 Dec 2002 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267475AbSLEVQV>; Thu, 5 Dec 2002 16:16:21 -0500
Received: from [202.88.171.30] ([202.88.171.30]:58807 "EHLO dikhow.hathway.com")
	by vger.kernel.org with ESMTP id <S267473AbSLEVPm>;
	Thu, 5 Dec 2002 16:15:42 -0500
Date: Fri, 6 Dec 2002 02:53:07 +0530
From: Dipankar Sarma <dipankar@gamebox.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>,
       Ravikiran G Thirumalai <kiran@in.ibm.com>
Subject: Re: [patch] kmalloc_percpu  -- 2 of 2
Message-ID: <20021206025307.A20657@dikhow>
Reply-To: dipankar@gamebox.net
References: <20021204174209.A17375@in.ibm.com> <20021204174550.B17375@in.ibm.com> <3DEE58CB.737259DB@digeo.com> <20021205091217.A11438@in.ibm.com> <3DEED6FA.B179FAFD@digeo.com> <20021205162329.A12588@in.ibm.com> <3DEFB0EB.9893DB9@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEFB0EB.9893DB9@digeo.com>; from akpm@digeo.com on Thu, Dec 05, 2002 at 09:10:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 09:10:16PM +0100, Andrew Morton wrote:
> 
> I'd suggest that you drop the new allocator until a compelling
> need for it (in real, live 2.5/2.6 code) has been demonstrated.

Fine with me since atleast one workaround for fragmentation with small 
allocations is known. I can't see anything in 2.5 timeframe 
requiring small per-cpu allocations.

Would you like me to resubmit a simple kmalloc-only version ?

Thanks
Dipankar
