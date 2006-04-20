Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWDTRg0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWDTRg0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 13:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWDTRg0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 13:36:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40933 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751067AbWDTRgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 13:36:25 -0400
Date: Thu, 20 Apr 2006 19:36:16 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Hellwig <hch@infradead.org>, Nick Piggin <npiggin@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch 2/5] mm: deprecate vmalloc_to_pfn
Message-ID: <20060420173616.GE21660@wotan.suse.de>
References: <20060228202202.14172.60409.sendpatchset@linux.site> <20060228202223.14172.21110.sendpatchset@linux.site> <20060420172240.GD21659@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060420172240.GD21659@infradead.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 06:22:40PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 20, 2006 at 07:06:30PM +0200, Nick Piggin wrote:
> > Deprecate vmalloc_to_pfn.
> 
> I don't think there's any point to even keep it.  There's a trivial replcement.

It is exported, is the only thing. I tend to stick my head in the sand
with these matters, and try to go with whatever I think will help Andrew
merge it.

If nobody cares, I'd just as soon remove it completely.

