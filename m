Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751518AbVK3TgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVK3TgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 14:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751520AbVK3TgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 14:36:17 -0500
Received: from mail.kroah.org ([69.55.234.183]:3810 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751516AbVK3TgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 14:36:17 -0500
Date: Wed, 30 Nov 2005 11:35:59 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-devel@lists.sourceforge.net, Grant Coady <gcoady@gmail.com>
Subject: Re: [GIT PATCH] USB patches for 2.6.15-rc3
Message-ID: <20051130193559.GA13615@suse.de>
References: <20051130055607.GA4406@kroah.com> <Pine.LNX.4.64.0511301018280.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511301018280.3099@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2005 at 10:23:34AM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 29 Nov 2005, Greg KH wrote:
> >
> >  include/linux/pci_ids.h           |    3 --
> > 
> > Grant Coady:
> >       pci_ids.h: remove duplicate entries
> 
> Why is this in the USB tree, and WHY THE HELL DOES IT EXIST IN THE FIRST 
> PLACE?

Sorry, in the body of the message I stated that I had a pci and a hwmon
driver patch too.  I should have corrected the Subject: too.

> Not only does it have absolutely nothing to do with USB, it's totally 
> bogus and incorrect. The commit log is also non-sensical, since it points 
> to a commit that doesn't even exist in that tree.
> 
> It causes
> 
> 	drivers/ide/pci/amd74xx.c:77: error: PCI_DEVICE_ID_AMD_CS5536_IDE undeclared here (not in a function)
> 
> Grr.

Ugh, I thought Grant wanted this in for the main kernel tree, sorry.

Grant, what git tree were you referring to?

I think I'll go back to sending individual patches late in the -rc
series from now on :)

Sorry for the trouble, and thanks for reverting the pci id patch in your
tree.

greg k-h
