Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266129AbUHMQEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266129AbUHMQEY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbUHMQEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:04:24 -0400
Received: from omx2-ext.SGI.COM ([192.48.171.19]:62430 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266129AbUHMQEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:04:23 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] allocate page caches pages in round robin fasion
Date: Fri, 13 Aug 2004 09:04:00 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <2sxuC-429-3@gated-at.bofh.it> <m3657nu9dl.fsf@averell.firstfloor.org>
In-Reply-To: <m3657nu9dl.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408130904.00537.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 12, 2004 6:14 pm, Andi Kleen wrote:
> I don't like this approach using a dynamic counter. I think it would
> be better to add a new function that takes the vma and uses the offset
> into the inode for static interleaving (anonymous memory would still
> use the vma offset). This way you would have a good guarantee that the
> interleaving stays interleaved even when the system swaps pages in and
> out and you're less likely to get anomalies in the page distribution.

That sounds like a good approach, care to show me exactly what you mean with a 
patch? :)

Thanks,
Jesse
