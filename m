Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbUEHA3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbUEHA3A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 20:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUEHA0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 20:26:44 -0400
Received: from mail.kroah.org ([65.200.24.183]:18308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263937AbUEHAXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 20:23:15 -0400
Date: Fri, 7 May 2004 15:38:22 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Exporting physical topology information
Message-ID: <20040507223822.GJ14660@kroah.com>
References: <20040317213714.GD23195@localhost> <20040319175957.GB10432@kroah.com> <200403191053.38131.jbarnes@sgi.com> <200405071313.43493.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405071313.43493.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 01:13:43PM -0700, Jesse Barnes wrote:
> On Friday, March 19, 2004 10:53 am, Jesse Barnes wrote:
> > Here's the (very platform specific) patch I did for Altix, just to see
> > what it would look like, and to solicit comments.  There's some other
> > per-node stuff that would be nice to have available to userspace too,
> > mostly for administrative purposes, like the chipset revision and
> > type, firmware revision, and other hardware specific details.  One way
> > to export that sort of thing is with some sort of arbitrary data blob,
> > but like you said, that violates the sysfs one file, one value
> > principle.
> 
> Greg, any comments on this?  (Sorry I was gone for much of last month and lost 
> track of this thread.)  Maybe a whole subdirectory containing physical tag, 
> version files and such would make more sense?

I think my main comments was you should work with the other numa people
so that you all agree on one common format to export this data in sysfs.
If you all agree that this is the way to do it, I'll accept the patch :)

thanks,

greg k-h
