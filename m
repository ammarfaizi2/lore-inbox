Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTFAS1C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 14:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264696AbTFAS1C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 14:27:02 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24531 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264692AbTFAS1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 14:27:01 -0400
Date: Sun, 1 Jun 2003 20:40:17 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: David Brownell <david-b@pacbell.net>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5 patch] let USB_GADGET depend on USB
Message-ID: <20030601184017.GC29425@fs.tum.de>
References: <20030531221855.GM29425@fs.tum.de> <3ED93D30.4070704@pacbell.net> <20030601111303.GV29425@fs.tum.de> <3EDA0B4E.504@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDA0B4E.504@pacbell.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 07:18:54AM -0700, David Brownell wrote:
> 
> As I had already said (in response to your email that reported
> that problem), the fix is to revert the recent changeset that
> links gadget code twice.  Here's a patch that undoes it.

Ups, sorry, I confused this with a different issue.

> - Dave
> 

> --- a/drivers/usb/Makefile	Sun Jun  1 07:14:50 2003
> +++ b/drivers/usb/Makefile	Sun Jun  1 07:14:50 2003
> @@ -59,6 +59,3 @@
>  obj-$(CONFIG_USB_TIGL)		+= misc/
>  obj-$(CONFIG_USB_USS720)	+= misc/
>  
> -obj-$(CONFIG_USB_NET2280)	+= gadget/
> -obj-$(CONFIG_USB_ZERO)		+= gadget/
> -obj-$(CONFIG_USB_ETH)		+= gadget/


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

