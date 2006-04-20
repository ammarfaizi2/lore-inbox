Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbWDTUbn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWDTUbn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 16:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWDTUbn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 16:31:43 -0400
Received: from mail.kroah.org ([69.55.234.183]:63670 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751191AbWDTUbm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 16:31:42 -0400
Date: Thu, 20 Apr 2006 13:18:00 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] arch/i386/pci/irq.c - new VIA chipsets (fwd)
Message-ID: <20060420201800.GC3922@suse.de>
References: <200604150112.k3F1Cwsa029071@hera.kernel.org> <44404A91.1000302@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44404A91.1000302@garzik.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 09:21:21PM -0400, Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> >diff --git a/arch/i386/pci/irq.c b/arch/i386/pci/irq.c
> >index 3ca59ca..7323544 100644
> >--- a/arch/i386/pci/irq.c
> >+++ b/arch/i386/pci/irq.c
> >@@ -588,7 +588,10 @@ static __init int via_router_probe(struc
> > 	case PCI_DEVICE_ID_VIA_82C596:
> > 	case PCI_DEVICE_ID_VIA_82C686:
> > 	case PCI_DEVICE_ID_VIA_8231:
> >+	case PCI_DEVICE_ID_VIA_8233A:
> > 	case PCI_DEVICE_ID_VIA_8235:
> >+	case PCI_DEVICE_ID_VIA_8237:
> >+	case PCI_DEVICE_ID_VIA_8237_SATA:
> 
> Why did this get merged with the bogus PCI ID?

Sorry, I'll fix it up in the next round of PCI patches.

thanks,

greg k-h
