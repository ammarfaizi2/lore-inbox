Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262945AbVCJRao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbVCJRao (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbVCJR1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 12:27:39 -0500
Received: from mail.kroah.org ([69.55.234.183]:34477 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262749AbVCJRUD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 12:20:03 -0500
Date: Thu, 10 Mar 2005 09:11:38 -0800
From: Greg KH <greg@kroah.com>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: tridge@samba.org, LKML <linux-kernel@vger.kernel.org>,
       "J. Bruce Fields" <bfields@citi.umich.edu>,
       Neil Brown <neilb@cse.unsw.edu.au>, Andrew Morton <akpm@osdl.org>
Subject: Re: make -j4 gets stuck w/ ccache over NFS - solved!
Message-ID: <20050310171138.GB16774@kroah.com>
References: <20041207022429.GA5295@jupiter.solarsys.private> <16822.44167.836780.288332@samba.org> <20050310054737.GA27656@jupiter.solarsys.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310054737.GA27656@jupiter.solarsys.private>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 12:47:37AM -0500, Mark M. Hoffman wrote:
> Finally I noticed this patch from -mm1... and it solves the problem.
> 
> nfsd--lockd-dont-try-to-match-callback-requests-against-export-table.patch
> 
> How I tested: I applied the first 12 patches in 2.6.11-mm1; the above
> mentioned was last - couldn't reproduce the bug.  When I unapplied just
> that one, I saw it again.
> 
> original bug report:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110238645132535&w=3
> 
> Greg: have you considered this one for 2.6.11.x?

No, it hasn't been submitted to the stable@kernel.org address :)

thanks,

greg k-h
