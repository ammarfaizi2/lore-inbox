Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbUDWUjW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbUDWUjW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUDWUjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:39:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48393 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261389AbUDWUjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:39:20 -0400
Date: Fri, 23 Apr 2004 21:39:16 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Message-ID: <20040423213916.D2896@flint.arm.linux.org.uk>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <1082723147.1843.14.camel@merlin> <20040423205504.B2896@flint.arm.linux.org.uk> <1082751264.4294.1.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1082751264.4294.1.camel@pegasus>; from marcel@holtmann.org on Fri, Apr 23, 2004 at 10:14:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2004 at 10:14:24PM +0200, Marcel Holtmann wrote:
> should we apply the pcmcia_get_sys_device() patch from Dmitry for now to
> fix the current drivers that need a device for loading the firmware?

I don't think so - it obtains the struct device for the bridge itself
which has nothing to do with the card inserted in the slot.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
