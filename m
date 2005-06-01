Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVFAV3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVFAV3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 17:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVFAV0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 17:26:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:36756 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261292AbVFAV0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 17:26:03 -0400
Date: Wed, 1 Jun 2005 14:36:16 -0700
From: Greg KH <greg@kroah.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH] PCI: add modalias sysfs file for pci devices
Message-ID: <20050601213616.GA4192@kroah.com>
References: <11163663063114@kroah.com> <429C95BF.3070102@tls.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <429C95BF.3070102@tls.msk.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2005 at 08:50:07PM +0400, Michael Tokarev wrote:
> Greg KH wrote:
> > [PATCH] PCI: add modalias sysfs file for pci devices
> [With similar patch and $MODALIAS in hotplug path stuff
>  submitted for USB]
> 
> Speaking of all this...  While the two (USB and PCI) are
> most important nowadays...  Hmm, so probably all other
> similar "busses", like PCMCIA, even bluetooth, and "not
> so obvious ones" like IDE and SCSI, and PNP&EISA -- this
> same approach may be used for all, providing device/modalias
> file for all (scsi:t0 for sd_mod etc), and $MODALIAS for
> hotpluggable ones, with appropriate .modalias in modules...
> 
> I mean, are we on the way to converting just everything
> into this modalias thing, so that hotplug/modloading will
> be just one-liner?

Yes, care to make up patches for these other busses?

thanks,

greg k-h
