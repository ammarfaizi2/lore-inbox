Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVCIVKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVCIVKr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 16:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVCIVHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 16:07:52 -0500
Received: from waste.org ([216.27.176.166]:20190 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261650AbVCIVGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 16:06:38 -0500
Date: Wed, 9 Mar 2005 13:06:31 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309210631.GY3163@waste.org>
References: <20050309083923.GA20461@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309083923.GA20461@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
> And to further test this whole -stable system, I've released 2.6.11.2.
> It contains one patch, which is already in the -bk tree, and came from
> the security team (hence the lack of the longer review cycle).
> 
> It's available now in the normal kernel.org places:
> 	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
> which is a patch against the 2.6.11.1 release.

Argh! @*#$&!!&! 

> If consensus arrives
> that this patch should be against the 2.6.11 tree, it will be done that
> way in the future.

Consensus arrived back when 2.6.8.1 came out.

Please, folks, there are automated tools that "know" about kernel
release numbering and so on. Said tools broke with 2.6.11.1 because it
wasn't in the same place that 2.6.8.1 was and now this breaks with all
precedent by being an interdiff along a branch.

Fixing it in the future is too #*$%* late because you've now turned it
into a special case.

-- 
Mathematics is the supreme nostalgia of our time.
