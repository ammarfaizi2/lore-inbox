Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422710AbWJRRRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbWJRRRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 13:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422716AbWJRRRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 13:17:23 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:16050 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1422710AbWJRRRW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 13:17:22 -0400
X-ORBL: [67.117.73.34]
Date: Wed, 18 Oct 2006 20:16:53 +0300
From: Tony Lindgren <tony@atomide.com>
To: Samuel Ortiz <samuel@sortiz.org>
Cc: Komal Shah <komal_shah802003@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Missed OMAP IrDA patch for 2.6.19?
Message-ID: <20061018171652.GF4439@atomide.com>
References: <20061005170906.22410.qmail@web37915.mail.mud.yahoo.com> <20061009231042.GC4696@sortiz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061009231042.GC4696@sortiz.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Samuel Ortiz <samuel@sortiz.org> [061009 18:56]:
> Hi Komal,
> 
> On Thu, Oct 05, 2006 at 10:09:06AM -0700, Komal Shah wrote:
> > Samuel,
> > 
> > Why the following patch never made it to -mm tree
> > OR to your IrDA tree for considering under 2.6.19?
> I had another look at the patch, and I just saw that it depends on
> GPIOEXPANDER_OMAP. This symbol is currently only defined in Tony's tree, so
> it would make more sense for Tony to push it there first.

OK, netdev tree is the way to get this into mainline. Mainline tree
already has include/asm-arm/arch-omap/gpioexpander.h, but not
drivers/i2c/chips/gpio_expander_omap.c.

The gpio_expander_omap.c (which really is TI PCF8574) issues need
to be sorted out with the I2C folks, so meanwhile I suggest to continue
these two independently of each other. Especially since the IrDA drive
driver is usable on H2.
 
> Tony, can you push this patch to your tree ? I ACKed it after the second
> iteration.
> 
> Cheers,
> Samuel.
> 
> 
> > http://lkml.org/lkml/2006/8/27/141

I'll push it, I guess I must have missed the original message.

Regards,

Tony
