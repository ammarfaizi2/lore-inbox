Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVIZVt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVIZVt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbVIZVt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:49:26 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:20651 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932093AbVIZVt0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:49:26 -0400
Message-ID: <43386CDF.5070905@austin.ibm.com>
Date: Mon, 26 Sep 2005 16:49:19 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050909 Fedora/1.7.10-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/9] fragmentation avoidance
References: <4338537E.8070603@austin.ibm.com>
In-Reply-To: <4338537E.8070603@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> well.  I believe the patches are now ready for inclusion in -mm, and after
> wider testing inclusion in the mainline kernel.
> 
> The patch set consists of 9 patches that can be merged in 4 separate 
> blocks,
> with the only dependency being that the lower numbered patches are merged
> first.  All are against 2.6.13.
> Patch 1 defines the allocation flags and adds them to the allocator calls.
> Patch 2 defines some new structures and the macros used to access them.
> Patch 3-8 implement the fully functional fragmentation avoidance.
> Patch 9 is trivial but useful for memory hotplug remove.
> ---
> Patch 10 -- not ready for merging -- extends fragmentation avoidance to the
> percpu allocator.  This patch works on 2.6.13-rc1 but only with NUMA off on
> 2.6.13; I am having a great deal of trouble tracking down why, help 
> would be
> appreciated.  I include the patch for review and test purposes as I plan to
> submit it for merging after resolving the NUMA issues.

It was pointed out that I did not make it clear that I would like the 9 patches
in this series merged into -mm.  They are ready to go.

Patch 10 is just a bonus patch you can ignore.
