Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWHQLp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWHQLp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 07:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWHQLp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 07:45:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:16269 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964823AbWHQLp6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 07:45:58 -0400
Date: Wed, 16 Aug 2006 22:58:14 -0700
From: Greg KH <greg@kroah.com>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver conversion
Message-ID: <20060817055814.GA14950@kroah.com>
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 04:26:35AM +0000, Michal Piotrowski wrote:
> 
> Hi,
> 
> pci_module_init is obsolete.
> 
> This patch series converts pci_module_init to pci_register_driver.
> 
> 
> Can I remove this?
> 
> include/linux/pci.h:385
> /*
>  * pci_module_init is obsolete, this stays here till we fix up all usages of it
>  * in the tree.
>  */
> #define pci_module_init pci_register_driver

As repeated numerous times, it's up to the network developers if they
will take this or not.

I'll hold off on taking this series, please push it through the driver
subsystem maintainers.

thanks,

greg k-h
