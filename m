Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269453AbUJLEpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269453AbUJLEpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 00:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269457AbUJLEph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 00:45:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:42889 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269453AbUJLEpe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 00:45:34 -0400
Date: Mon, 11 Oct 2004 21:45:11 -0700
From: Greg KH <greg@kroah.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc4
Message-ID: <20041012044511.GA22512@kroah.com>
References: <1097504290l.6177l.1l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097504290l.6177l.1l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 02:18:10PM +0000, J.A. Magallon wrote:
> Hi...
> 
> Lets polish it... I get this warnings on build:
> 
>  CC      drivers/pci/msi.o
> drivers/pci/msi.c: In function `msi_set_mask_bit':
> drivers/pci/msi.c:80: warning: passing arg 2 of `writel' makes pointer from 
> integer without a cast
> drivers/pci/msi.c: In function `set_msi_affinity':
> drivers/pci/msi.c:121: warning: passing arg 1 of `readl' makes pointer from 
> integer without a cast
> drivers/pci/msi.c:126: warning: passing arg 2 of `writel' makes pointer 
> from integer without a cast
> drivers/pci/msi.c: In function `msi_free_vector':
> drivers/pci/msi.c:838: warning: passing arg 2 of `writel' makes pointer 
> from integer without a cast
> drivers/pci/msi.c: In function `reroute_msix_table':
> drivers/pci/msi.c:901: warning: passing arg 1 of `readl' makes pointer from 
> integer without a cast
> drivers/pci/msi.c:903: warning: passing arg 2 of `writel' makes pointer 
> from integer without a cast
> drivers/pci/msi.c:905: warning: passing arg 1 of `readl' makes pointer from 
> integer without a cast
> drivers/pci/msi.c:907: warning: passing arg 2 of `writel' makes pointer 
> from integer without a cast
> drivers/pci/msi.c:909: warning: passing arg 1 of `readl' makes pointer from 
> integer without a cast
> drivers/pci/msi.c:911: warning: passing arg 2 of `writel' makes pointer 
> from integer without a cast

These are fixed in the -mm tree, and do not constitute a "bug fix" that
would cause them to make it into 2.6.9-rc4 right now.

thanks,

greg k-h
