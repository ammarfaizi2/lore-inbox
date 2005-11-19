Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVKSV7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVKSV7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Nov 2005 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVKSV7w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Nov 2005 16:59:52 -0500
Received: from holomorphy.com ([66.93.40.71]:9898 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1750940AbVKSV7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Nov 2005 16:59:52 -0500
Date: Sat, 19 Nov 2005 13:58:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] unpaged: unifdefed PageCompound
Message-ID: <20051119215839.GP6916@holomorphy.com>
References: <20051117.154323.10862063.davem@davemloft.net> <Pine.LNX.4.61.0511192003060.2846@goblin.wat.veritas.com> <20051119205557.GO6916@holomorphy.com> <20051119.134114.115024780.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051119.134114.115024780.davem@davemloft.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: William Lee Irwin III <wli@holomorphy.com>
> Date: Sat, 19 Nov 2005 12:55:57 -0800
> > I usually end up deferring to Dave on the driver issues, but this time
> > I can independently agree in an informed manner.

On Sat, Nov 19, 2005 at 01:41:14PM -0800, David S. Miller wrote:
> What is it needed for in this case?  We never try to use those
> pci_alloc_consistent() pages independantly, ie. freeing up
> individual pages from a non-zero order allocation.
> Just curious. :-)

I glossed over the pci_alloc_consistent() part of hugh's msg. I
recalled the sound driver from memory. I don't know whether
pci_alloc_consistent()'s sparc-specific usage includes a similar
behavior, but never saw it when I looked for allocators of higher-order
pages that free fragments of them at a time. The audit was far from
comprehensive, though.

I must defer once again. =)


-- wli
