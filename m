Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbTFSG4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 02:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265718AbTFSG4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 02:56:45 -0400
Received: from granite.he.net ([216.218.226.66]:53508 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265716AbTFSG4p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 02:56:45 -0400
Date: Thu, 19 Jun 2003 00:10:23 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ehci_hcd.c linkage fix
Message-ID: <20030619071023.GA2093@kroah.com>
References: <20030618215233.6698960c.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030618215233.6698960c.akpm@digeo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 09:52:33PM -0700, Andrew Morton wrote:
> 
> 
> With CONFIG_HOTPLUG=n we get, at link time:
> 
> drivers/usb/host/ehci-hcd.c:977: pci_ids causes a section type conflict
> 
> The fix is to remove the const, but I'm darned if I can remember why.  Can
> anyone remind me?

I have no idea why, I haven't heard of that one before.

greg k-h
