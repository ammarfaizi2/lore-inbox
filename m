Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267700AbUHENvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267700AbUHENvF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267683AbUHENtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:49:47 -0400
Received: from cantor.suse.de ([195.135.220.2]:7577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267671AbUHENnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:43:52 -0400
Date: Thu, 5 Aug 2004 15:43:46 +0200
From: Andi Kleen <ak@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: Hugetlb demanding paging for -mm tree
Message-ID: <20040805134346.GD16763@wotan.suse.de>
References: <200408051329.i75DT3Y26431@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408051329.i75DT3Y26431@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patches are broken into two pieces.  But they should be applied together
> to have correct functionality for hugetlb demand paging.
> 
> 00.demandpaging.patch - core hugetlb demand paging
> 01.overcommit.patch   - hugetlbfs strict overcommit accounting.
> 
> Testing and comments are welcome.  Thanks.

Looks good so far to me. I can later add NUMA API on top of it.
Just one nit: please add a printk for the OOM case.
And: please don't send patches uuencoded, that makes it harder 
to review.

I didn't see the second part yet.

-Andi
