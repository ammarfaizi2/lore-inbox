Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbUKEXUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbUKEXUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUKEXSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:18:34 -0500
Received: from mail.kroah.org ([69.55.234.183]:42705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261264AbUKEXRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:17:20 -0500
Date: Fri, 5 Nov 2004 15:06:53 -0800
From: Greg KH <greg@kroah.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <vandrove@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20041105230653.GF31080@kroah.com>
References: <20040908031537.92163.qmail@web14929.mail.yahoo.com> <20040908235046.GB8361@kroah.com> <9e4733910410071920531730a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910410071920531730a3@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 10:20:39PM -0400, Jon Smirl wrote:
> Linus has requested that the sysfs rom attribute be changed to require
> enabling before it works. echo "0" to the attribute to disable,
> echoing anything else enables the rom output. The concern is that
> something like a file browser could inadvertently read the attribute
> and change the state of the hardware without the user's knowledge.
> 
> The attached patch includes the previous patch plus the enabling logic.


Applied, thanks.

greg k-h

