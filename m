Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbULQW3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbULQW3h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbULQW3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 17:29:37 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60118 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262178AbULQW3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 17:29:34 -0500
Date: Fri, 17 Dec 2004 14:11:29 -0800
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@linen.sps.mot.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk@arm.linux.org.uk
Subject: Re: [RFC][PATCH] Add platform_get_resource_byname & platform_get_resource_byirq
Message-ID: <20041217221129.GA22885@kroah.com>
References: <Pine.LNX.4.61.0412081703030.4040@linen.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412081703030.4040@linen.sps.mot.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 05:16:16PM -0600, Kumar Gala wrote:
> Adds the ability to find a resource or irq on a platform device by its 
> resource name.  This patch also tweaks how resource names get set.  
> Before, resources names were set to pdev->dev.bus_id, now that only 
> happens if the resource name has not been previous set.
> 
> All of this allows us to find a resource without assuming what order the 
> resources are in.
> 
> Signed-off-by; Kumar Gala <kumar.gala@freescale.com>

Thanks, I've applied this (minus the bogus .h file, and plus the proper
.h file change.)

greg k-h
