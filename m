Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVADPyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVADPyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 10:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbVADPyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 10:54:17 -0500
Received: from de01egw02.freescale.net ([192.88.165.103]:16574 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261690AbVADPyL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 10:54:11 -0500
In-Reply-To: <20041217221129.GA22885@kroah.com>
References: <20041217221129.GA22885@kroah.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <CACE2CCC-5E68-11D9-BC22-000393DBC2E8@freescale.com>
Content-Transfer-Encoding: 8BIT
Cc: "Kumar Gala" <galak@linen.sps.mot.com>, <linux-kernel@vger.kernel.org>,
       <rmk@arm.linux.org.uk>, <akpm@osdl.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: [RFC][PATCH] Add platform_get_resource_byname & platform_get_resource_byirq
Date: Tue, 4 Jan 2005 09:53:35 -0600
To: "Greg KH" <greg@kroah.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

Any update on when these patches will go to linus or akpm.

thanks

- kumar

On Dec 17, 2004, at 4:11 PM, Greg KH wrote:

> On Wed, Dec 08, 2004 at 05:16:16PM -0600, Kumar Gala wrote:
>  > Adds the ability to find a resource or irq on a platform device by 
> its
> > resource name.  This patch also tweaks how resource names get set. 
> > Before, resources names were set to pdev->dev.bus_id, now that only
> > happens if the resource name has not been previous set.
>  >
> > All of this allows us to find a resource without assuming what order 
> the
> > resources are in.
>  >
> > Signed-off-by; Kumar Gala <kumar.gala@freescale.com>
>
> Thanks, I've applied this (minus the bogus .h file, and plus the proper
>  .h file change.)
>
> greg k-h
>  -
>  To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

