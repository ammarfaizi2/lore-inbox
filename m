Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTIBRRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 13:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263590AbTIBRRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 13:17:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:27576 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261874AbTIBRRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 13:17:30 -0400
Date: Tue, 2 Sep 2003 10:11:50 -0700
From: Greg KH <greg@kroah.com>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: disabling USB host-to-host interfaces causes kernel compile-time error
Message-ID: <20030902171150.GA17807@kroah.com>
References: <20030901184823.GA23256@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901184823.GA23256@buici.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 11:48:23AM -0700, Marc Singer wrote:
> Kernel source: 2.6.0-test4
> 
> I'm attaching a .config that shows this.  If I have USB enabled but
> have removed all of the USB host-to-host options, I get this error
> 
>   CC [M]  drivers/usb/net/usbnet.o
> drivers/usb/net/usbnet.c:2640: #error You need to configure some hardware for this driver
> drivers/usb/net/usbnet.c:321: warning: `always_connected' defined but not used
> 
> Adding CONFIG_USB_AN2720, for example, eliminates the error.

Mind posting this on the linux-usb-devel mailing list and possibly ccing
the usbnet author and maintainer so they have a chance to fix this?

thanks,

greg k-h
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Mon, Sep 01, 2003 at 11:48:23AM -0700, Marc Singer wrote:
> Kernel source: 2.6.0-test4
> 
> I'm attaching a .config that shows this.  If I have USB enabled but
> have removed all of the USB host-to-host options, I get this error
> 
>   CC [M]  drivers/usb/net/usbnet.o
> drivers/usb/net/usbnet.c:2640: #error You need to configure some hardware for this driver
> drivers/usb/net/usbnet.c:321: warning: `always_connected' defined but not used
> 
> Adding CONFIG_USB_AN2720, for example, eliminates the error.

Mind posting this on the linux-usb-devel mailing list and possibly ccing
the usbnet author and maintainer so they have a chance to fix this?

thanks,

greg k-h
