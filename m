Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUHWXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUHWXWO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268296AbUHWXQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 19:16:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:9671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S268272AbUHWXOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 19:14:35 -0400
Date: Mon, 23 Aug 2004 15:51:45 -0700
From: Greg KH <greg@kroah.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Martin Mares <mj@ucw.cz>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Message-ID: <20040823225145.GK4694@kroah.com>
References: <20040818181310.12047.qmail@web14927.mail.yahoo.com> <200408181437.06887.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408181437.06887.jbarnes@engr.sgi.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 02:37:06PM -0400, Jesse Barnes wrote:
> On Wednesday, August 18, 2004 2:13 pm, Jon Smirl wrote:
> > I haven't received any comments on pci-sysfs-rom-17.patch. Is everyone
> > asleep or is it ready to be pushed upstream? I'm still not sure that
> > anyone has tried it on a ppc machine.
> >
> > Since it's small I'll attach it again for your convenience.
> 
> Works for me on ia64.  Greg, is this one ready for your queue?

There are a few minor coding style issues (the initial '{' for a
function needs to be on a new line) and I need a "Signed-off-by:" line,
and it probably will not apply right now due to the pci quirks changes
(if you rediff it against the latest -mm tree, that should fix it.)

Other than that, it looks good to me.

thanks,

greg k-h
