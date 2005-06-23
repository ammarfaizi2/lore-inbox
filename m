Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVFWI2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVFWI2y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263277AbVFWIYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 04:24:17 -0400
Received: from holomorphy.com ([66.93.40.71]:48819 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262639AbVFWH0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 03:26:13 -0400
Date: Thu, 23 Jun 2005 00:26:09 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Hugh Dickins <hugh@veritas.com>, Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [patch][rfc] 2/5: micro optimisation for mm/rmap.c
Message-ID: <20050623072609.GA3334@holomorphy.com>
References: <42BA5F37.6070405@yahoo.com.au> <42BA5F5C.3080101@yahoo.com.au> <42BA5F7B.30904@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42BA5F7B.30904@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 05:06:35PM +1000, Nick Piggin wrote:
> +		index = (address - vma->vm_start) >> PAGE_SHIFT;
> +		index += vma->vm_pgoff;
> +		index >>= PAGE_CACHE_SHIFT - PAGE_SHIFT;
> +		page->index = index;

linear_page_index()


-- wli
