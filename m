Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265617AbUAGVRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265623AbUAGVRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:17:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:28167 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265617AbUAGVRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:17:06 -0500
Date: Wed, 7 Jan 2004 21:16:56 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: "Miscellaneous" bus for the driver model?
Message-ID: <20040107211656.D18708@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Kernel development list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@digitalimplant.org>
References: <Pine.LNX.4.44L0.0401071054220.850-100000@ida.rowland.org> <20040107173345.GD31177@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040107173345.GD31177@kroah.com>; from greg@kroah.com on Wed, Jan 07, 2004 at 09:33:45AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 09:33:45AM -0800, Greg KH wrote:
> On Wed, Jan 07, 2004 at 11:00:16AM -0500, Alan Stern wrote:
> > Would it make sense for the driver model core to add a "miscellaneous" or 
> > "other" bus, intended for devices or drivers that are one-of-a-kind or 
> > otherwise non-standard?  Kind of similar to the platform bus but meant 
> > for new things, not part of a legacy or other system/architecture-specific 
> > base?
> 
> That's what the "legacy" bus is for.  There's a patch floating around
> that renames that bus to "platform" to remove any connotation that
> "legacy" might occur.

Can we get this patch merged ASAP please?  It should really have gone
in before 2.6 so we don't have this change during a stable kernel series.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
