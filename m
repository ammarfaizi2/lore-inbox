Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269042AbUI2VPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269042AbUI2VPc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 17:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269049AbUI2VOi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 17:14:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:16269 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269031AbUI2VMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 17:12:51 -0400
Date: Wed, 29 Sep 2004 12:49:13 -0700
From: Greg KH <greg@kroah.com>
To: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5]: usb-serial cleanup.
Message-ID: <20040929194912.GA15585@kroah.com>
References: <20040927135330.428851a9.lcapitulino@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927135330.428851a9.lcapitulino@conectiva.com.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2004 at 01:53:30PM -0300, Luiz Fernando N. Capitulino wrote:
>  Hi Greg,
> 
>  I did some trivial cleanup in usb-serial subsystem code
> (drivers/usb/serial/usb-serial.c).
> 
>  The main change is the first patch, which moves the search
> in device list out of usb_serial_probe(). It is the first
> of some patches to make usb_serial_probe() more simple (today
> it is an very big function).
> 
>  I'm sending only one patch for usb_serial_probe() organization
> because I'm not certain if is the better/right thing to do, so,
> comments and flames are welcome. :)
> 
>  Well, hope some of the patches to be applyed.
> 
>  Summary:
> 
> [PATCH 1/5]: usb-serial: Moves the search in device list out of usb_serial_probe().
> [PATCH 2/5]: usb-serial: create_serial() return value trivial fix.
> [PATCH 3/5]: usb-serial: return_serial() trivial cleanup.
> [PATCH 4/5]: usb-serial: usb_serial_register() cleanup.
> [PATCH 5/5]: usb-serial: Add module version information.

Thanks, I've applied all 5 patches to my trees.

greg k-h
