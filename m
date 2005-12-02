Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbVLBVlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbVLBVlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 16:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750790AbVLBVlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 16:41:08 -0500
Received: from mail.kroah.org ([69.55.234.183]:21410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750766AbVLBVlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 16:41:07 -0500
Date: Fri, 2 Dec 2005 13:40:54 -0800
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, "Brown, Len" <len.brown@intel.com>
Subject: Re: [2.6.15-rc4] oops in acpiphp
Message-ID: <20051202214054.GB3948@suse.de>
References: <4390B646.60709@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4390B646.60709@pobox.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 04:01:58PM -0500, Jeff Garzik wrote:
> 
> Booting with acpiphp on this dual core, dual package (2x2) box causes an 
> oops.

Hm, this is oopsing in the pci express hotplug driver, not the acpi
hotplug driver.  Did you mean to load that driver? 

I'll look at your other attachments for more details...

thanks,

greg k-h
