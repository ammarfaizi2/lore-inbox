Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319479AbSH3AJD>; Thu, 29 Aug 2002 20:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319480AbSH3AJD>; Thu, 29 Aug 2002 20:09:03 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:25361 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319479AbSH3AJC>;
	Thu, 29 Aug 2002 20:09:02 -0400
Date: Thu, 29 Aug 2002 17:12:34 -0700
From: Greg KH <greg@kroah.com>
To: abhishek Sinha <aby_sinha@yahoo.com>
Cc: linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: AMD 768 USB Controller
Message-ID: <20020830001234.GJ5074@kroah.com>
References: <20020830000206.32051.qmail@web20702.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020830000206.32051.qmail@web20702.mail.yahoo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 05:02:06PM -0700, abhishek Sinha wrote:
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-ohci.c: USB OHCI at membase 0xf88ed000, IRQ 10
> usb-ohci.c: usb-02:00.0, Advanced Micro Devices [AMD] AMD-768 [??] USB
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 4 ports detected

Looks like the usb-ohci driver bound to your device just fine :)

Why do you think you have a UHCI device?  Does 'lspci -v' say that?

And what happens when you plug in your USB device?

thanks,

greg k-h
