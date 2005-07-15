Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263180AbVGOCPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263180AbVGOCPl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 22:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbVGOCPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 22:15:24 -0400
Received: from cantor2.suse.de ([195.135.220.15]:53377 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263117AbVGOCOp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 22:14:45 -0400
Date: Fri, 15 Jul 2005 04:14:43 +0200
From: Andi Kleen <ak@suse.de>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andi Kleen <ak@suse.de>, Mark Gross <mgross@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Why is 2.6.12.2 less stable on my laptop than 2.6.10?
Message-ID: <20050715021443.GR23737@wotan.suse.de>
References: <200507140912.22532.mgross@linux.intel.com.suse.lists.linux.kernel> <p73wtnsx5r1.fsf@bragg.suse.de> <200507142209.11427.kernel-stuff@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507142209.11427.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 10:09:11PM -0400, Parag Warudkar wrote:
> I have always wondered how Windows got it right circa 1995 - Version after 
> version, several different hardwares and it always works reliably. 
> I am using Linux since 1997 and not a single time have I succeeded in getting 
> it to suspend and resume reliably. 

What happens with Windows is that the Laptop vendor takes the
frozen Windows version available at the time the machine hits the market 
and then tweaks the BIOS and the drivers until everything runs and then
releases the machine.

But if you use newer (or older) W. releases or even service packs or different
drivers on that machine you end up exactly with the same problem.

> Is it such an un-interesting subject to warrant serious effort or there is a 
> lot of hardware documentation missing or in general the driver model and OS 
> design itself makes it impossible to get suspend / resume right?

I think you underestimate the complexity of the problem. Suspend/resume
is a fragile cooperation  of many many different components in the kernel/firmware/hardware
and all of them have to work flawlessly together.  That's hard.

-Andi

