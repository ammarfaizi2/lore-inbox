Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280627AbRKJMjC>; Sat, 10 Nov 2001 07:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280629AbRKJMix>; Sat, 10 Nov 2001 07:38:53 -0500
Received: from host213-121-105-27.in-addr.btopenworld.com ([213.121.105.27]:64502
	"HELO mail.dark.lan") by vger.kernel.org with SMTP
	id <S280627AbRKJMip>; Sat, 10 Nov 2001 07:38:45 -0500
Subject: Re: MS Natural keyboard extra keys using usb
From: Greg Sheard <greg@ecsc.co.uk>
To: Greg KH <greg@kroah.com>
Cc: Daniel Ceregatti <vi@sh.nu>, linux-kernel@vger.kernel.org
In-Reply-To: <20011109170008.A10527@kroah.com>
In-Reply-To: <3BEC3B3A.6040005@sh.nu>  <20011109170008.A10527@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 10 Nov 2001 12:38:09 +0000
Message-Id: <1005395889.32176.1.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-11-10 at 01:00, Greg KH wrote:
> On Fri, Nov 09, 2001 at 12:23:22PM -0800, Daniel Ceregatti wrote:
> > 
> > Ever since 2.4.10, these keys have stopped working.
> 
> Are you sure you are still using the HID keyboard drivers, and not the
> usbkbd (boot protocol keyboard) driver?
> 

A quick squint at menuconfig in 2.4.13 offers CONFIG_USB_HIDDEV:

  Say Y here if you want to support HID devices (from the USB
  specification standpoint) that aren't strictly user interface
  devices, like monitor controls and Uninterruptable Power Supplies.
  It is also used for "consumer keys" on multimedia keyboards and
  USB speakers.

  This module supports these devices separately using a separate
  event interface on /dev/usb/hiddevX (char 180:96 to 180:111).
  This driver requires CONFIG_USB_HID.

IMHO this may offer the functionality that's disappeared - whilst I also
have a Natural Keyboard, I've yet to bother mapping the consumer keys.

Cheers,
Greg.



