Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSJIVbi>; Wed, 9 Oct 2002 17:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262042AbSJIVbi>; Wed, 9 Oct 2002 17:31:38 -0400
Received: from holomorphy.com ([66.224.33.161]:18918 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261815AbSJIVbi>;
	Wed, 9 Oct 2002 17:31:38 -0400
Date: Wed, 9 Oct 2002 14:33:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] CONFIG_DEBUG_SLAB broken on SMP
Message-ID: <20021009213335.GM10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <3DA48875.6020604@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA48875.6020604@colorfullife.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 09:50:13PM +0200, Manfred Spraul wrote:
> 2.5.41-mm1 contains a partially rewritten slab, which performs the 
> poisoning before adding an object into the cpu caches. Additionally, 
> even caches with constructors are not poisoned - ctor and dtor calls are 
> performed in kmem_cache_alloc/free.


On an unrelated note, I have a very tiny but useful (for me) feature
request for the slab rewrite:

Can you make ctor return a success/failure code?


Thanks,
Bill
