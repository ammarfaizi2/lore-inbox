Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWEGIsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWEGIsF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 04:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWEGIsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 04:48:04 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:7496 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932108AbWEGIsB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 04:48:01 -0400
Date: Sun, 7 May 2006 11:47:56 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Jon Mason <jdmason@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, tony.luck@intel.com,
       linux-ia64@vger.kernel.org, mulix@mulix.org
Subject: Re: [PATCH 1/3] swiotlb: SWIOTLB Cleanup.
Message-ID: <20060507084756.GE6015@rhun.haifa.ibm.com>
References: <20060504205822.GC14361@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504205822.GC14361@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2006 at 03:58:23PM -0500, Jon Mason wrote:

> SWIOTLB Cleanup.  Mostly a comment and white space clean-up.
> However, some compiler cache optimizations (via the static and
> __read_mostly keywords) were added, and
> swiotlb_init_with_default_size was renamed swiotlb_init (as that
> functional was redundant)
> 
> This patch has been tested individually and cumulatively on x86_64 and
> cross-compile tested on IA64.  Since I have no IA64 hardware, any
> testing on that platform would be appreciated.

Looks good.

> Signed-off-by: Jon Mason <jdmason@us.ibm.com>

Acked-by: Muli Ben-Yehuda <muli@il.ibm.com>

Cheers,
Muli
