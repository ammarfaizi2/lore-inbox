Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261747AbVFFXUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbVFFXUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 19:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVFFXUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 19:20:14 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:32855 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261752AbVFFXNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 19:13:36 -0400
Date: Mon, 6 Jun 2005 16:13:25 -0700
From: Greg KH <gregkh@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       roland@topspin.com
Subject: Re: pci_enable_msi() for everyone?
Message-ID: <20050606231325.GA11610@suse.de>
References: <20050603224551.GA10014@kroah.com> <20050605.124612.63111065.davem@davemloft.net> <20050606225548.GA11184@suse.de> <42A4D771.7080400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A4D771.7080400@pobox.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 07:08:33PM -0400, Jeff Garzik wrote:
> Greg KH wrote:
> >Why would it matter?  The driver shouldn't care if the interrupts come
> >in via the standard interrupt way, or through MSI, right?  And if it
> 
> It matters.
> 
> Not only the differences DaveM mentioned, but also simply that you may 
> assume your interrupt is not shared with anyone else.

Ok, and again, how would the call, pci_in_msi_mode(struct pci_dev *dev)
not allow for the driver to determine this?

thanks,

greg k-h
