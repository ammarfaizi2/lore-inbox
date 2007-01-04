Return-Path: <linux-kernel-owner+w=401wt.eu-S965110AbXADWUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965110AbXADWUq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965108AbXADWUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:20:46 -0500
Received: from mail.kroah.org ([69.55.234.183]:54137 "EHLO perch.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965109AbXADWUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:20:45 -0500
Date: Thu, 4 Jan 2007 14:19:16 -0800
From: Greg KH <gregkh@suse.de>
To: Tejun Heo <htejun@gmail.com>
Cc: jeff@garzik.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [RFC,PATCHSET] Managed device resources
Message-ID: <20070104221916.GI28445@suse.de>
References: <1167146313307-git-send-email-htejun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167146313307-git-send-email-htejun@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 27, 2006 at 12:18:33AM +0900, Tejun Heo wrote:
> Hello, all.
> 
> This patchset implements managed device resources, in short, devres.

<good writeup snipped>

I like this.  It feels a bit awkward, and creating a bunch of duplicate
functions is "messy", but I can't think of any other way to achive this.

Your writeup in this message is also quite good, care to add it to the
Documentation/ directory in the kernel?

> ## Patchset
> 
> This patchset contains the following 12 patches and is against the
> current 2.6.20-rc2 (3bf8ba38f38d3647368e4edcf7d019f9f8d9184a).
> 
> 01	: implement devres core
> 02-06	: implement managed resource interface for IO region, IRQ, DMA,
> 	  PCI and iomap

Unless anyone objects, I'll add the first 6 patches here to my tree for
testing in -mm for a bit.

Hm, but I guess without the follow-up patches for libata, it will not
really get tested much.  Jeff, if I accept this, what's your feelings of
letting libata be the "test bed" for it?

thanks,

greg k-h
