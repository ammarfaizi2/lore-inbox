Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261926AbULVAqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261926AbULVAqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 19:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbULVAqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 19:46:07 -0500
Received: from mail.kroah.org ([69.55.234.183]:37549 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261926AbULVAqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 19:46:01 -0500
Date: Tue, 21 Dec 2004 16:45:50 -0800
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow struct bin_attributes in class devices
Message-ID: <20041222004550.GB13167@kroah.com>
References: <200412211619.52596.jbarnes@engr.sgi.com> <20041222002810.GA12886@kroah.com> <200412211630.36844.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412211630.36844.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 04:30:36PM -0800, Jesse Barnes wrote:
> On Tuesday, December 21, 2004 4:28 pm, Greg KH wrote:
> > On Tue, Dec 21, 2004 at 04:19:52PM -0800, Jesse Barnes wrote:
> > > This small patch adds routines to create and remove bin_attribute files
> > > for class devices.  One intended use is for binary files corresponding to
> > > PCI busses, like bus legacy I/O ports or ISA memory.
> > >
> > >  drivers/base/class.c   |   16 ++++++++++++++++
> > >  include/linux/device.h |    5 ++++-
> > >  2 files changed, 20 insertions(+), 1 deletion(-)
> > >
> > > Signed-off-by: Jesse Barnes <jbarnes@sgi.com>
> >
> > Ugh, we'll get this eventually... You forgot a EXPORT_SYMBOL_GPL() so
> > that modules can use these functions :)
> >
> > Third time's a charm :)
> 
> Doh!  Here you go.

Applied, thanks.

greg k-h
