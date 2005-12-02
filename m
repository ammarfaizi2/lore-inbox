Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750712AbVLBMcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbVLBMcL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 07:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750713AbVLBMcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 07:32:10 -0500
Received: from ns2.suse.de ([195.135.220.15]:27799 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750712AbVLBMcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 07:32:10 -0500
Date: Fri, 2 Dec 2005 13:32:08 +0100
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Ravikiran G Thirumalai <kiran@scalex86.org>, ak@suse.de,
       discuss@x86-64.org, shai@scalex86.org, rusty@rustcorp.com.au
Subject: Re: [discuss] [RFC] NUMA aware kthread_create() ?
Message-ID: <20051202123208.GA9766@wotan.suse.de>
References: <20051202081028.GA5312@localhost.localdomain> <20051202082309.GC5312@localhost.localdomain> <20051202010548.4da3d1bb.akpm@osdl.org> <439023A3.4090201@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <439023A3.4090201@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 11:36:19AM +0100, Eric Dumazet wrote:
> Hi
> 
> Is there any plans about making a kthread_create_on_cpu() version of 
> kthread_create(), so that memory allocated for thread stack/info is 
> allocated on the node of the target CPU ?

I don't know of plans. Feel free to do it, although I'm not sure
it will help very much because the stack is relatively small.

-Andi
