Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263627AbVCEEfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263627AbVCEEfM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263257AbVCDXn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:43:27 -0500
Received: from atlmail.prod.rxgsys.com ([64.74.124.160]:42400 "EHLO
	bastet.signetmail.com") by vger.kernel.org with ESMTP
	id S263243AbVCDV6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:58:48 -0500
Date: Fri, 4 Mar 2005 16:58:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.11.1
Message-ID: <20050304215822.GA24843@havoc.gtf.org>
References: <20050304175302.GA29289@kroah.com> <20050304124431.676fd7cf.akpm@osdl.org> <4228D43E.1040903@pobox.com> <20050304135113.68c50e13.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304135113.68c50e13.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 01:51:13PM -0800, Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> > > cramfs-small-stat2-fix.patch
> > > setup_per_zone_lowmem_reserve-oops-fix.patch
> > > dv1394-ioctl-retval-fix.patch
> > > ppc32-compilation-fixes-for-ebony-luan-and-ocotea.patch
> > > nfsd--sgi-921857-find-broken-with-nohide-on-nfsv3.patch
> > > nfsd--exportfs-reduce-stack-usage.patch
> > 
> > Unless it's crashing for people, stack usage is IMO a wanted-fix not 
> > needed-fix.
> 
> Sure.  The patch is bog-obvious though.
> 
> > 
> > > nfsd--svcrpc-add-a-per-flavor-set_client-method.patch
> > 
> > is this critical?
> 
> Doubt it, unless the succeeding patches have a dependency on it.  But the
> other patches have not been tested without this one being present.
> 
> 
> These patches have been in mm for four weeks, so it's probably OK from a
> stability POV to take them straight into linux-release.  If they were
> fresher then the way to handle them would be to merge them into Linus's
> tree and backport in a couple of weeks time.

Cool, fair enough.  linux-release sounds fine.

	Jeff



