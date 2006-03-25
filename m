Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWCYCi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWCYCi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 21:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWCYCi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 21:38:29 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:31903
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751231AbWCYCi2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 21:38:28 -0500
Date: Fri, 24 Mar 2006 18:38:08 -0800
From: Greg KH <greg@kroah.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Patch 0/9] Performance
Message-ID: <20060325023808.GB6416@kroah.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net> <20060314192824.GB27012@kroah.com> <4422BBD9.40901@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4422BBD9.40901@watson.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 10:16:41AM -0500, Shailabh Nagar wrote:
> Greg KH wrote:
> > On Mon, Mar 13, 2006 at 07:40:34PM -0500, Shailabh Nagar wrote:
> >
> >>This is the next iteration of the delay accounting patches
> >>last posted at
> >>	http://www.ussg.iu.edu/hypermail/linux/kernel/0602.3/0893.html
> >
> >
> > Do you have any benchmark numbers with this patch applied and with it
> > not applied?  Last I heard it was a measurable decrease for some
> > "important" benchmark results...
> >
> > thanks,
> >
> > greg k-h
> 
> Here are some numbers for the latest set of posted patches
> using microbenchmarks hackbench, kernbench and lmbench.
> 
> I was trying to get the real/big benchmark numbers too but
> it looks like getting a run whose numbers can be trusted
> will take a bit longer than expected. Preliminary runs of
> transaction processing benchmarks indicate that overhead
> actually decreases with the patch (as also seen in some of
> the lmbench numbers below).

That's good to hear.

But your .5% is noticable on the +patch results, which I don't think
people who take performance issues seriously will like (that's real
money for the big vendors.)  And distros will be forced to enable that
option in their kernels, so those vendors will have to get that
percentage back some other way...

thanks,

greg k-h
