Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUEEXni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUEEXni (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 19:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264699AbUEEXni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 19:43:38 -0400
Received: from mail.kroah.org ([65.200.24.183]:64465 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264705AbUEEXnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 19:43:24 -0400
Date: Wed, 5 May 2004 16:42:05 -0700
From: Greg KH <greg@kroah.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: PCI devices with no PCI_CACHE_LINE_SIZE implemented
Message-ID: <20040505234205.GA31119@kroah.com>
References: <20040429195301.GB15106@lists.us.dell.com> <20040505223102.GF30003@kroah.com> <20040505224847.GA2283@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505224847.GA2283@lists.us.dell.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 05:48:47PM -0500, Matt Domsch wrote:
> On Wed, May 05, 2004 at 03:31:02PM -0700, Greg KH wrote:
> > On Thu, Apr 29, 2004 at 02:53:01PM -0500, Matt Domsch wrote:
> > > a) need this be a warning, wouldn't KERN_DEBUG suffice, if a message
> > > is needed at all?  This is printed in pci_generic_prep_mwi().
> > 
> > Yes, we should make that KERN_DEBUG.  I don't have a problem with that.
> > Care to make a patch?
> 
> Appended for 2.6.6-rc3.  I'll send a 2.4.x patch separately.

I've applied this for 2.6.  I'm not the 2.4 pci maintainer, so I can't
help you out there, sorry.

greg k-h
