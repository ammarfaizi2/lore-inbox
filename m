Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVAMB0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVAMB0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 20:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVAMBYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 20:24:25 -0500
Received: from mail.kroah.org ([69.55.234.183]:62918 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261479AbVAMBTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 20:19:44 -0500
Date: Wed, 12 Jan 2005 17:19:28 -0800
From: Greg KH <greg@kroah.com>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, Dominik Brodowski <linux@dominikbrodowski.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Downgrade printk that complains about unsupported PCI PM caps
Message-ID: <20050113011927.GA16245@kroah.com>
References: <20050112004147.GA22156@kroah.com> <20050108055142.GB8571@kroah.com> <20050106123710.GA8125@dominikbrodowski.de> <9726.1105105388@redhat.com> <26980.1105357916@redhat.com> <15971.1105557696@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15971.1105557696@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 07:21:36PM +0000, David Howells wrote:
> 
> The attached patch downgrades to KERN_DEBUG level the printk that issues a
> notification that an unsupported version of the PCI power management registers
> has been encountered by pci_set_power_state().
> 
> Signed-Off-By: David Howells <dhowells@redhat.com>

Applied, thanks.

greg k-h
