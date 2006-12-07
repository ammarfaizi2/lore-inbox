Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163550AbWLGWkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163550AbWLGWkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163548AbWLGWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:40:10 -0500
Received: from mx1.suse.de ([195.135.220.2]:46619 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163550AbWLGWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:40:09 -0500
Date: Thu, 7 Dec 2006 14:39:49 -0800
From: Greg KH <gregkh@suse.de>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Jeff Garzik <jeff@garzik.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Disable INTx when enabling MSI
Message-ID: <20061207223949.GA18477@suse.de>
References: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612071659010.20138@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 05:31:33PM -0500, Daniel Barkalow wrote:
> Some device manufacturers seem to think it's the OS's responsibility to 
> disable legacy interrupt delivery when using MSI. If the driver doesn't 
> handle it (which they generally don't), and the device isn't PCI-Express, 
> a steady stream of legacy interrupts will be delivered in addition to the 
> MSI ones, eventually leading to the legacy IRQ getting disabled, which 
> kills any device that shares it.
> 
> Jeff proposed a patch in http://lkml.org/lkml/2006/11/21/332 when Linus 
> wanted to do it in the PCI layer, but nobody seems to have told the actual 
> PCI maintainer.

Care to take Jeff's proposed patch, verify that it works and forward it
on to me?

thanks,

greg k-h
