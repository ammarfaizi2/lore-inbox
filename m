Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030423AbVIVPzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbVIVPzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbVIVPzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:55:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46784 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030420AbVIVPzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:55:32 -0400
Date: Thu, 22 Sep 2005 08:55:05 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <4332D2D9.7090802@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0509220853070.16871@schroedinger.engr.sgi.com>
References: <43308324.70403@cosmosbay.com> <200509221454.22923.ak@suse.de>
 <20050922125849.GA27413@infradead.org> <200509221505.05395.ak@suse.de>
 <Pine.LNX.4.62.0509220835310.16793@schroedinger.engr.sgi.com>
 <4332D2D9.7090802@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2005, Eric Dumazet wrote:

> vmalloc_node() should be seldom used, at driver init, or when a new ip_tables
> is loaded. If it happens to be a performance problem, then we can optimize it.

Allright. However, there are a couple of uses of vmalloc_node that I can 
see right now and they will likely increase in the future.

> Why should we spend days of work for a function that is yet to be used ?

I already did a vmalloc_node patch. So no need for spending days of work. 
The patch can wait until it becomes performance critical.


