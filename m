Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbVJZW0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbVJZW0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVJZW0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:26:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:10650 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751251AbVJZW0r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:26:47 -0400
Date: Wed, 26 Oct 2005 15:26:15 -0700
From: Greg KH <greg@kroah.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [RFC patch 3/3] remove pci_driver.owner and .name fields
Message-ID: <20051026222615.GA8884@kroah.com>
References: <20051026204802.123045000@antares.localdomain> <20051026204909.995658000@antares.localdomain> <20051026211129.GA7918@kroah.com> <436001A3.1000906@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <436001A3.1000906@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 12:22:27AM +0200, Laurent Riffard wrote:
> 
> Le 26.10.2005 23:11, Greg KH a ?crit :
> > On Wed, Oct 26, 2005 at 10:48:05PM +0200, Laurent riffard wrote:
> > 
> >>This is the final cleanup : deletion of pci_driver.name and .owner
> >>happens now. 
> > 
> > 
> > what?  Did you actually try to build a kernel with this patch applied?
> 
> No, a bunch of patch #2-like have to be applied first.
> 
> This third patch is to be applied after *all* the drivers are
> converted to use the pci_driver.driver.{name|owner} fields.
> 
> > Sorry, but I think we have to wait a long time before this can be
> > appliedr...
> 
> Yes, I know. Is it worth to do it ?

The .owner stuff, yes.  Do that first and then we can revisit the .name
stuff and see if that is worth it or not.

thanks,

greg k-h
