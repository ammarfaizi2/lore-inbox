Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVJEQuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVJEQuU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 12:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVJEQuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 12:50:20 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:49295 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030238AbVJEQuS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 12:50:18 -0400
Subject: Re: [PATCH 5/7] Fragmentation Avoidance V16: 005_fallback
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144612.11796.35309.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 09:49:49 -0700
Message-Id: <1128530989.26009.30.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 15:46 +0100, Mel Gorman wrote:
> 
> +#ifdef CONFIG_ALLOCSTATS
> +       zone->reserve_count[type]++;
> +#endif

Did this sneak up from another patch?

-- Dave

