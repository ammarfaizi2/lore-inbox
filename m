Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161284AbWG1UcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWG1UcN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161286AbWG1UcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:32:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:59087 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161284AbWG1UcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:32:11 -0400
Date: Fri, 28 Jul 2006 13:27:49 -0700
From: Greg KH <greg@kroah.com>
To: Theodore Bullock <tbullock@nortel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration
Message-ID: <20060728202749.GA23662@kroah.com>
References: <25E284CCA9C9A14B89515B116139A94D0C6DF1A4@zrtphxm0.corp.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25E284CCA9C9A14B89515B116139A94D0C6DF1A4@zrtphxm0.corp.nortel.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 02:07:12PM -0400, Theodore Bullock wrote:
> It would be really nice to see the arcmsr driver integrated into the
> mainline kernel in the nearish future.
> 
> Ideally, the driver would be available before the next major
> distribution is published so that the hardware can be officially
> supported by the distribution developers eg. Novell, Red Hat, Canonical
> ... etc.
> 
> After a brief review of upcoming schedules, Fedora Core looks to be
> updated next in October with the last test release currently scheduled
> for October. After that it will probably be SuSE.
> 
> We have a good number of workstations with this hardware here, but
> support isn't available from our distribution.
> 
> Checking the recent posts it seems that there are two outstanding issues
> 
> > - PAE (cast of dma_addr_t to unsigned long) issues. 
> > - SYNCHRONIZE_CACHE is ignored.  This is wrong.  The sync cache in the
> 
> > shutdown notifier isn't sufficient.
> 
> That said, we have been using an older version of the driver off the
> Areca website for some time now with no major issues (other than kernel
> update problems). 
> 
> Is it possible to get the driver integrated and fix these problems
> after?

Why not fix them up and submit the corrected driver?  If no one wants to
put the effort into fixing these issues now, why would they do the work
later?

thanks,

greg k-h
