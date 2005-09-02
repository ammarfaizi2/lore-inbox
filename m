Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVIBP7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVIBP7B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 11:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751513AbVIBP7B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 11:59:01 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53768 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751512AbVIBP7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 11:59:00 -0400
Date: Fri, 2 Sep 2005 16:58:50 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
       ralf@linux-mips.org, starvik@axis.com, dev-etrax@axis.com
Subject: Re: [2.6 patch] drivers/serial/crisv10.c: remove {,un}register_serial dummies
Message-ID: <20050902165850.C6546@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, amax@us.ibm.com,
	ralf@linux-mips.org, starvik@axis.com, dev-etrax@axis.com
References: <20050831103352.A26480@flint.arm.linux.org.uk> <20050901231258.GD3657@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050901231258.GD3657@stusta.de>; from bunk@stusta.de on Fri, Sep 02, 2005 at 01:12:58AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 01:12:58AM +0200, Adrian Bunk wrote:
> On Wed, Aug 31, 2005 at 10:33:52AM +0100, Russell King wrote:
> >...
> > In addition, the following drivers declare functions of the same name.
> > The maintainers of these need to look to see why, and eliminate them
> > where possible.
> > 
> > drivers/serial/crisv10.c:register_serial(struct serial_struct *req)
> > drivers/serial/crisv10.c:void unregister_serial(int line)
> 
> It seems we can simply kill these dummies with this patch.

Thanks, applied.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
