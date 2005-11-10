Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVKJAN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVKJAN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVKJAN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:13:58 -0500
Received: from holomorphy.com ([66.93.40.71]:19928 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S1751092AbVKJAN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:13:58 -0500
Date: Wed, 9 Nov 2005 16:13:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Adam Litke <agl@us.ibm.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       David Gibson <david@gibson.dropbear.id.au>, hugh@veritas.com,
       rohit.seth@intel.com, kenneth.w.chen@intel.com
Subject: Re: [PATCH 3/4] Hugetlb: Reorganize hugetlb_fault to prepare for COW
Message-ID: <20051110001309.GM29402@holomorphy.com>
References: <1131578925.28383.9.camel@localhost.localdomain> <1131579527.28383.22.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131579527.28383.22.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2005 at 05:38:47PM -0600, Adam Litke wrote:
> Hugetlb: Reorganize hugetlb_fault to prepare for COW
> This patch splits the "no_page()" type activity into its own function,
> hugetlb_no_page().  hugetlb_fault() becomes the entry point for hugetlb faults
> and delegates to the appropriate handler depending on the type of fault.  Right
> now we still have only hugetlb_no_page() but a later patch introduces a COW
> fault.
> Original post by David Gibson <david@gibson.dropbear.id.au>
> Version 2: Wed 9 Nov 2005
> 	Broken out into a separate patch
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Adam Litke <agl@us.ibm.com>

Straightforward enough.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
