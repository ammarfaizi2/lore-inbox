Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTJ2XbV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTJ2XbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:31:21 -0500
Received: from mail.kroah.org ([65.200.24.183]:22428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262040AbTJ2XbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:31:18 -0500
Date: Wed, 29 Oct 2003 15:30:42 -0800
From: Greg KH <greg@kroah.com>
To: Andreas Schwab <schwab@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent PCI driver registration failure oopsing
Message-ID: <20031029233042.GB1707@kroah.com>
References: <20031028100402.F22424@flint.arm.linux.org.uk> <jehe1tvdsq.fsf@sykes.suse.de> <20031028105126.I22424@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028105126.I22424@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 10:51:26AM +0000, Russell King wrote:
> On Tue, Oct 28, 2003 at 11:48:05AM +0100, Andreas Schwab wrote:
> > Russell King <rmk+lkml@arm.linux.org.uk> writes:
> > > +	return rc < 0 ? : 0;
> > 
> > Are you sure you want to return 1 if rc < 0?
> 
> Argh.  Definitely not.  Thanks for spotting that.
> 
> --- orig/include/linux/pci.h	Thu Mar 13 14:24:56 2003
> +++ linux/include/linux/pci.h	Wed Mar 12 19:37:41 2003

Thanks, I've applied this and will send it to Linus when 2.6.0 is out.

greg k-h
