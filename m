Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVBAAkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVBAAkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 19:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261499AbVBAAdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 19:33:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:61845 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261495AbVBAAZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 19:25:09 -0500
Date: Mon, 31 Jan 2005 16:18:33 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-kernel@vger.kernel.org, bjorn.helgaas@hp.com,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] pci_proc_domain
Message-ID: <20050201001833.GH7498@kroah.com>
References: <20050117192335.GI30982@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117192335.GI30982@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 07:23:35PM +0000, Matthew Wilcox wrote:
> 
> There's no need for the architectures to know how to name busses,
> so replace pci_name_bus with pci_proc_domain -- a predicate to allow
> architectures to choose whether domains are included in /proc/bus/pci
> or not.  I've converted all architectures but only tested ia64 and a
> CONFIG_PCI_DOMAINS=n build.

Applied, thanks.

greg k-h
