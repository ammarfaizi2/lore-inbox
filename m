Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271220AbUJVLX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271220AbUJVLX4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271217AbUJVLXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:23:55 -0400
Received: from holomorphy.com ([207.189.100.168]:16834 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S271220AbUJVLXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:23:20 -0400
Date: Fri, 22 Oct 2004 04:23:08 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, raybry@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: Hugepages demand paging V1 [3/4]: Overcommit handling
Message-ID: <20041022112308.GS17038@holomorphy.com>
References: <B05667366EE6204181EABE9C1B1C0EB501F2ADFB@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0410212151310.3524@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0410212157280.3524@schroedinger.engr.sgi.com> <20041022110116.GA17699@infradead.org> <20041022111259.GQ17038@holomorphy.com> <20041022111626.GA18037@infradead.org> <20041022112101.GR17038@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022112101.GR17038@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 12:16:26PM +0100, Christoph Hellwig wrote:
>> I thought that was the state of the art for hugetlb pages already?

On Fri, Oct 22, 2004 at 04:21:01AM -0700, William Lee Irwin III wrote:
> Only vacuously so, for mainline is not handling hugetlb faults.
> The real impediment to all this is that no one is bothering to dredge
> up architecture manuals for the architectures they're touching to
> create plausible equivalents of update_mmu_cache(), clear_dcache_page()
> (not considered by Lameter's patches at all), et al for hugetlb.

flush_dcache_page(), sorry.


-- wli
