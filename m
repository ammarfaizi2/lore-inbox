Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVCJEeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVCJEeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 23:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVCJEd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 23:33:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:16609 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262333AbVCIXMV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:12:21 -0500
Date: Wed, 9 Mar 2005 15:11:57 -0800
From: Greg KH <greg@kroah.com>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050309231156.GB31064@kroah.com>
References: <20050309083923.GA20461@kroah.com> <20050309210631.GY3163@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050309210631.GY3163@waste.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2005 at 01:06:31PM -0800, Matt Mackall wrote:
> On Wed, Mar 09, 2005 at 12:39:23AM -0800, Greg KH wrote:
> > And to further test this whole -stable system, I've released 2.6.11.2.
> > It contains one patch, which is already in the -bk tree, and came from
> > the security team (hence the lack of the longer review cycle).
> > 
> > It's available now in the normal kernel.org places:
> > 	kernel.org/pub/linux/kernel/v2.6/patch-2.6.11.2.gz
> > which is a patch against the 2.6.11.1 release.
> 
> Argh! @*#$&!!&! 
> 
> > If consensus arrives
> > that this patch should be against the 2.6.11 tree, it will be done that
> > way in the future.
> 
> Consensus arrived back when 2.6.8.1 came out.

It did?  So, what was it agreed to be?  Any pointers to that agreement?

> Please, folks, there are automated tools that "know" about kernel
> release numbering and so on. Said tools broke with 2.6.11.1 because it
> wasn't in the same place that 2.6.8.1 was and now this breaks with all
> precedent by being an interdiff along a branch.

2.6.11.1 is now in the proper place, sorry for any inconvience that
caused.  This happened yesterday.

> Fixing it in the future is too #*$%* late because you've now turned it
> into a special case.

No, I can always respin the patch, and re-release it if it's a problem.

thanks,

greg k-h
