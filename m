Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265507AbSJSE3n>; Sat, 19 Oct 2002 00:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265510AbSJSE3n>; Sat, 19 Oct 2002 00:29:43 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:18074 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265507AbSJSE3m>; Sat, 19 Oct 2002 00:29:42 -0400
Date: Sat, 19 Oct 2002 10:11:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockfree rtcache using RCU
Message-ID: <20021019101145.A27726@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20021019065210.A26806@in.ibm.com> <20021018.183811.124466701.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021018.183811.124466701.davem@redhat.com>; from davem@redhat.com on Fri, Oct 18, 2002 at 06:38:11PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 06:38:11PM -0700, David S. Miller wrote:
> 
> Dipankar, I had to revert this patch.
> 
> Where is read_barrier_depends() defined?
> I do not see it in current 2.5.x sources.

Well, the read_barrier_depends helper patch is applied now to 
Linus' tree. Sorry, I should have been more clear.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
