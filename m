Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268368AbUHLEjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268368AbUHLEjT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 00:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUHLEjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 00:39:19 -0400
Received: from mail.kroah.org ([69.55.234.183]:34694 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268368AbUHLEjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 00:39:17 -0400
Date: Wed, 11 Aug 2004 21:37:21 -0700
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Martin Mares <mj@ucw.cz>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040812043721.GA5622@kroah.com>
References: <20040811172800.GB14979@kroah.com> <20040812004525.26380.qmail@web14925.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812004525.26380.qmail@web14925.mail.yahoo.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 05:45:25PM -0700, Jon Smirl wrote:
> I have to add a pointer to struct pci_dev to track the attribute copy
> with the size in it. Would you rather have me add the pointer or or
> change the sysfs rules to state that a copy of the length is made?

Adding a pointer is fine for now.

thanks,

greg k-h
