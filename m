Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSEWRle>; Thu, 23 May 2002 13:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316972AbSEWRld>; Thu, 23 May 2002 13:41:33 -0400
Received: from maild.telia.com ([194.22.190.101]:51173 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S316970AbSEWRlb>;
	Thu, 23 May 2002 13:41:31 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
In-Reply-To: <20020520223132.GC25541@kroah.com>
From: Peter Osterlund <petero2@telia.com>
Date: 23 May 2002 19:41:22 +0200
Message-ID: <m2adqqiwxp.fsf@ppro.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> writes:

>   From now until July 1, I want everyone to test out both the uhci-hcd
>   and usb-uhci-hcd drivers on just about every piece of hardware they
>   can find.

I need this patch to convince the Makefile to build the new drivers.

--- linux/drivers/usb/Makefile.orig	Thu May 23 19:37:56 2002
+++ linux/drivers/usb/Makefile	Thu May 23 19:32:44 2002
@@ -12,6 +12,8 @@
 subdir-$(CONFIG_USB_EHCI_HCD)	+= host
 subdir-$(CONFIG_USB_OHCI_HCD)	+= host
 subdir-$(CONFIG_USB_OHCI)	+= host
+subdir-$(CONFIG_USB_UHCI_HCD)	+= host
+subdir-$(CONFIG_USB_UHCI_HCD_ALT)	+= host
 subdir-$(CONFIG_USB_UHCI_ALT)	+= host
 subdir-$(CONFIG_USB_UHCI)	+= host
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
