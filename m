Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbVKUBnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbVKUBnw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKUBnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:43:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:35545 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932168AbVKUBnv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:43:51 -0500
Date: Sun, 20 Nov 2005 17:22:56 -0800
From: Greg KH <greg@kroah.com>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2/5] Introduce PCI_NO_IRQ and pci_valid_irq()
Message-ID: <20051121012255.GA14047@kroah.com>
References: <E1Ee0Fz-0004CJ-Vg@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Ee0Fz-0004CJ-Vg@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 08:14:07PM -0500, Matthew Wilcox wrote:
> Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
> the value of PCI_NO_IRQ once all drivers have been audited.

And what will the value of PCI_NO_IRQ going to be?

thanks,

greg k-h
