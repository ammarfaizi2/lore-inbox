Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWDWVPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWDWVPK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 17:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWDWVPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 17:15:10 -0400
Received: from waste.org ([64.81.244.121]:15058 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751400AbWDWVPI (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Sun, 23 Apr 2006 17:15:08 -0400
Date: Sun, 23 Apr 2006 16:12:09 -0500
From: Matt Mackall <mpm@selenic.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [rfc][patch] radix-tree: small data structure
Message-ID: <20060423211209.GW15445@waste.org>
References: <444BA0A9.3080901@yahoo.com.au> <444BA150.7040907@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444BA150.7040907@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 01:46:24AM +1000, Nick Piggin wrote:
> Nick Piggin wrote:
> >With the previous patch, the radix_tree_node budget on my 64-bit
> >desktop is cut from 20MB to 10MB. This patch should cut it again
> >by nearly a factor of 4 (haven't verified, but 98ish % of files
> >are under 64K).
> >
> >I wonder if this would be of any interest for those who enable
> >CONFIG_BASE_SMALL?
> 
> Bah, wrong patch.

I like it.

-- 
Mathematics is the supreme nostalgia of our time.
