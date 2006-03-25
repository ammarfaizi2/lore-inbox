Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWCYCkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWCYCkO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 21:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWCYCkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 21:40:14 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:39604
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751659AbWCYCkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 21:40:12 -0500
Date: Fri, 24 Mar 2006 18:39:42 -0800
From: Greg KH <greg@kroah.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Andrew Morton <akpm@osdl.org>, Mark Lord <lkml@rtr.ca>,
       "David J. Wallace" <katana@onetel.com>, sdhci-devel@list.drzeus.cx,
       linux-kernel@vger.kernel.org
Subject: Re: [Sdhci-devel] Submission to the kernel?
Message-ID: <20060325023942.GC6416@kroah.com>
References: <4419FA7A.4050104@cogweb.net> <200603171042.52589.katana@onetel.com> <441AD537.5080403@rtr.ca> <441AD9C3.2090703@drzeus.cx> <20060317170126.GB32281@kroah.com> <441AEEBB.10104@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441AEEBB.10104@drzeus.cx>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 06:15:39PM +0100, Pierre Ossman wrote:
> Greg KH wrote:
> > In looking at the patches in -mm, I see the following 5:
> > 	secure-digital-host-controller-id-and-regs.patch
> > 	secure-digital-host-controller-id-and-regs-fix.patch
> > 	mmc-secure-digital-host-controller-interface-driver.patch
> > 	mmc-secure-digital-host-controller-interface-driver-fix.patch
> > 	mmc-sdhci-build-fix.patch
> >
> > Is that all that is needed for this feature?
> >
> > If so, I'll go try it out now...
> >   
> 
> That should be all yes.

Tried it out and it works great (also see it's in 2.6.16-git9 now).  Hm,
my laptop's slot also supports xD cards, which your patch set does not
yet support, right?

thanks,

greg k-h
