Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbVKOWAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbVKOWAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVKOWAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:00:33 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:25560 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750842AbVKOWAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:00:33 -0500
Subject: Re: [PATCH] Add NUMA policy support for huge pages.
From: Adam Litke <agl@us.ibm.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: akpm@osdl.org, linux-mm@kvack.org, ak@suse.de,
       linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com,
       wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.62.0511151342310.10995@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0511151342310.10995@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 15 Nov 2005 15:59:26 -0600
Message-Id: <1132091966.22243.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 13:44 -0800, Christoph Lameter wrote:
> The huge_zonelist() function in the memory policy layer
> provides an list of zones ordered by NUMA distance. The hugetlb
> layer will walk that list looking for a zone that has available huge pages
> but is also in the nodeset of the current cpuset.
> 
> This patch does not contain the folding of find_or_alloc_huge_page() that
> was controversial in the earlier discussion.

Yep, I still agree with this part.

> Signed-off-by: Christoph Lameter <clameter@sgi.com>

-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center

