Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVARQ3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVARQ3b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261341AbVARQ3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:29:31 -0500
Received: from mail.kroah.org ([69.55.234.183]:6793 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261343AbVARQ30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:29:26 -0500
Date: Tue, 18 Jan 2005 08:29:08 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: PCI patches not being reviewed
Message-ID: <20050118162908.GA12553@kroah.com>
References: <20050118022031.GL30982@parcelfarce.linux.theplanet.co.uk> <20050118062721.GA8951@kroah.com> <20050118122126.GM30982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050118122126.GM30982@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 12:21:26PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 17, 2005 at 10:27:22PM -0800, Greg KH wrote:
> > On Tue, Jan 18, 2005 at 02:20:31AM +0000, Matthew Wilcox wrote:
> > > 
> > > Greg, you're merging a lot of patches that aren't going through
> > > the linux-pci mailing list for review.  Please redirect patches that
> > > are sent to you directly so others can also review them.
> > 
> > I'm sorry, were there any that were recently applied that you feel
> > needed more review?
> 
> Yes, the PCI Express bridge driver is quite buggy.

It was posted a number of times to lkml in December, and it was
commented on by a few different people, and the patch went through a few
different revisions.  It also was in the -mm tree for awhile.

> I also think it's the wrong approach to take -- weren't you working on
> a generic way to have multiple drivers attach to the same device?

That's what the patch allows to happen.  I think it's the right
approach, what do you think it should do?

> > All major ones have been posted to linux-kernel
> > first, which, according to the MAINTAINERS file, is the list for pci
> > issues to be disccused on.  I'd be glad to change that entry, if you
> > think it would help out any.
> 
> That would certainly help; I'm not sure how anyone has time to read
> linux-kernel.  Here's a patch:

Hm, in sleeping on it, I think I'll leave it, as it's worked out just
fine for me for the past 2+ years I've been the PCI maintainer, this has
been the first it has come up.  But if it really annoys you, how about
just adding another L: entry for it, so people can choose where they
want to go?

Oh, and you forgot the Signed-off-by: line :)

thanks,

greg k-h
