Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbVIWSur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbVIWSur (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 14:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbVIWSur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 14:50:47 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:11274 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751142AbVIWSuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 14:50:46 -0400
Date: Fri, 23 Sep 2005 14:50:23 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, linux-ia64@vger.kernel.org, ak@suse.de,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
Subject: Re: [patch 2.6.13 0/6] swiotlb maintenance and x86_64 dma_sync_single_range_for_{cpu,device}
Message-ID: <20050923185021.GC6576@tuxdriver.com>
Mail-Followup-To: "Luck, Tony" <tony.luck@intel.com>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	discuss@x86-64.org, linux-ia64@vger.kernel.org, ak@suse.de,
	"Mallick, Asit K" <asit.k.mallick@intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F04795ED2@scsmsx401.amr.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 11:27:26AM -0700, Luck, Tony wrote:
> >> It should just go away once the GFP_DMA32 code is merged.
> >
> >Is that the plan?  I suppose it makes sense.

> I don't have a good (or in fact any) understanding of the impact
> of GFP_DMA32 on ia64.  People tell me it will all be good, but I'd
> like to hear from someone running it.
 
All the patches I saw were for x86_64.  So, the impact on ia64 should
be minimal... :-)

> If it is good, and if it is coming soon, then there is no point
> moving swiotlb.  But I don't know the answers to either of those
> questions.

The xen guys have an swiotlb implementation, although theres differs
somewhat.  Perhaps if we moved it out from under ia64, the two could
be consolidated?

John
-- 
John W. Linville
linville@tuxdriver.com
