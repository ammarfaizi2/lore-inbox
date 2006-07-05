Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWGEP4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWGEP4j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWGEP4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 11:56:39 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51601 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964800AbWGEP4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 11:56:38 -0400
Date: Wed, 5 Jul 2006 10:56:28 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Dave Jones <davej@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remove devinit from ioc4 pci_driver
In-Reply-To: <20060628193313.GA22146@redhat.com>
Message-ID: <20060705105544.C93671@pkunk.americas.sgi.com>
References: <20060628193313.GA22146@redhat.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit late and after-the-fact as I was on vacation, however:

Acked-by: Brent Casavant <bcasavan@sgi.com>



On Wed, 28 Jun 2006, Dave Jones wrote:

> Documention/pci.txt states..
> "The struct pci_driver shouldn't be marked with any of these tags."
> (Referring to __devinit and friends).
> 
> Signed-off-by: Dave Jones <davej@redhat.com>
> 
> --- linux-2.6/drivers/sn/ioc4.c~	2006-06-28 15:31:26.000000000 -0400
> +++ linux-2.6/drivers/sn/ioc4.c	2006-06-28 15:32:09.000000000 -0400
> @@ -438,7 +438,7 @@ static struct pci_device_id ioc4_id_tabl
>  	{0}
>  };
>  
> -static struct pci_driver __devinitdata ioc4_driver = {
> +static struct pci_driver ioc4_driver = {
>  	.name = "IOC4",
>  	.id_table = ioc4_id_table,
>  	.probe = ioc4_probe,
> 
> -- 
> http://www.codemonkey.org.uk
> 

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
