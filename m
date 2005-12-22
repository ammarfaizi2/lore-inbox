Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030260AbVLVUek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030260AbVLVUek (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 15:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbVLVUek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 15:34:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:16343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030260AbVLVUej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 15:34:39 -0500
Date: Thu, 22 Dec 2005 12:34:15 -0800
From: Greg KH <gregkh@suse.de>
To: Mark Maule <maule@sgi.com>
Cc: linuxppc64-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 0/3] msi abstractions and support for altix
Message-ID: <20051222203415.GA28240@suse.de>
References: <20051222201651.2019.37913.96422@lnx-maule.americas.sgi.com> <20051222202259.GA4959@suse.de> <20051222202627.GI17552@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051222202627.GI17552@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:26:27PM -0600, Mark Maule wrote:
> On Thu, Dec 22, 2005 at 12:22:59PM -0800, Greg KH wrote:
> > On Thu, Dec 22, 2005 at 02:15:44PM -0600, Mark Maule wrote:
> > > Resend #2: including linuxppc64-dev and linux-pci as well as PCI maintainer
> > 
> > I'll wait for Resend #3 based on my previous comments before considering
> > adding it to my kernel trees:)
> > 
> 
> Resend #2 includes the correction to the irq_vector[] declaration, and I
> responded to the question about setting irq_vector[0] if that's what you
> mean ...

Sorry, but I missed that last response.  Why do you set the [0] value in
a #ifdef now?

thanks,

greg k-h
