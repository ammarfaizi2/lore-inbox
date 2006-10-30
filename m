Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161241AbWJ3QDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161241AbWJ3QDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 11:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161216AbWJ3QDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 11:03:15 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:54518 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1161218AbWJ3QDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 11:03:12 -0500
Date: Mon, 30 Oct 2006 07:52:48 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Cc: akpm@osdl.org, mm-commits@vger.kernel.org, arnd@arndb.de,
       dhollis@davehollis.com, greg@kroah.com, jeff@garzik.org,
       oliver@neukum.name
Subject: Re: + usbnet-needs-mii.patch added to -mm tree
Message-Id: <20061030075248.93cc7612.randy.dunlap@oracle.com>
In-Reply-To: <200610300727.k9U7RfiJ011262@shell0.pdx.osdl.net>
References: <200610300727.k9U7RfiJ011262@shell0.pdx.osdl.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2006 23:27:41 -0800 akpm@osdl.org wrote:

> 
> The patch titled
>      usbnet needs mii
> has been added to the -mm tree.  Its filename is
>      usbnet-needs-mii.patch
> 
> See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
> out what to do about this
> 
> ------------------------------------------------------
> Subject: usbnet needs mii
> From: Andrew Morton <akpm@osdl.org>
> 
> For mii_nway_restart() and other such things.
> 
> Cc: Greg KH <greg@kroah.com>
> Cc: Jeff Garzik <jeff@garzik.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Hollis <dhollis@davehollis.com>
> Cc: Oliver Neukum <oliver@neukum.name>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/usb/net/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -puN drivers/usb/net/Kconfig~usbnet-needs-mii drivers/usb/net/Kconfig
> --- a/drivers/usb/net/Kconfig~usbnet-needs-mii
> +++ a/drivers/usb/net/Kconfig
> @@ -94,6 +94,7 @@ config USB_RTL8150
>  
>  config USB_USBNET
>  	tristate "Multi-purpose USB Networking Framework"
> +	depends on MII
>  	---help---
>  	  This driver supports several kinds of network links over USB,
>  	  with "minidrivers" built around a common network driver core
> _

David Brownell submitted a desired patch for this.
Not quite as simple (this one is like one that I did).

---
~Randy
