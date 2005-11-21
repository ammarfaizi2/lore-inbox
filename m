Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932176AbVKUCJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932176AbVKUCJi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 21:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKUCJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 21:09:38 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:31971 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932176AbVKUCJi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 21:09:38 -0500
Date: Sun, 20 Nov 2005 19:09:31 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2/5] Introduce PCI_NO_IRQ and pci_valid_irq()
Message-ID: <20051121020931.GN17171@parisc-linux.org>
References: <E1Ee0Fz-0004CJ-Vg@localhost.localdomain> <20051121012255.GA14047@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051121012255.GA14047@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2005 at 05:22:56PM -0800, Greg KH wrote:
> On Sun, Nov 20, 2005 at 08:14:07PM -0500, Matthew Wilcox wrote:
> > Explicitly initialise pci_dev->irq with PCI_NO_IRQ, allowing us to change
> > the value of PCI_NO_IRQ once all drivers have been audited.
> 
> And what will the value of PCI_NO_IRQ going to be?

It's actually going to go away; s/PCI_NO_IRQ/NO_IRQ/g.  I didn't want to
break all the drivers immediately.
