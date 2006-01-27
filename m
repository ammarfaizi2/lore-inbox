Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751586AbWA0Wug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751586AbWA0Wug (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbWA0Wug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 17:50:36 -0500
Received: from ns1.siteground.net ([207.218.208.2]:26823 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751585AbWA0Wuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 17:50:35 -0500
Date: Fri, 27 Jan 2006 14:50:36 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, shai@scalex86.org, netdev@vger.kernel.org,
       pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060127225036.GC3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <43DA9EFF.1020200@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43DA9EFF.1020200@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:30:23PM +0100, Eric Dumazet wrote:
> 
> There are several issues here :
> 
> alloc_percpu() current implementation is a a waste of ram. (because it uses 
> slab allocations that have a minimum size of 32 bytes)

Oh there was a solution for that :).  

http://lwn.net/Articles/119532/

I can quickly revive it if there is interest.


Thanks,
Kiran
