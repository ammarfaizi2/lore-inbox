Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWBRB6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWBRB6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 20:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWBRB6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 20:58:16 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:7641 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750741AbWBRB6Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 20:58:16 -0500
Date: Fri, 17 Feb 2006 17:58:08 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
Message-ID: <20060218015808.GB17653@kroah.com>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005707.13620.20538.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005707.13620.20538.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 04:57:07PM -0800, Roland Dreier wrote:
> From: Roland Dreier <rolandd@cisco.com>
> 
> This is a very large file with way too much code for a .h file.
> The functions look too big to be inlined also.  Is there any way
> for this code to move to a .c file?

Roland, your comments are fine, but what about the original author's
descriptions of what each patch are?

Come on, IBM allows developers to post code to lkml, just look at the
archives for proof.  For them to use a proxy like this is very strange,
and also, there is no Signed-off-by: record from the original authors,
which is not ok.

And why aren't you using the standard firmware interface in the kernel?

> +#ifndef CONFIG_PPC64
> +#ifndef Z_SERIES
> +#warning "included with wrong target, this is a p file"
> +#endif
> +#endif

It's a "p" file?  What's that?

Is this even needed?

thanks,

greg k-h
