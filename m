Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTIICW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTIICW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:22:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:47754 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263728AbTIICWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:22:18 -0400
Date: Mon, 8 Sep 2003 19:22:36 -0700
From: Greg KH <greg@kroah.com>
To: Momes <momes@mundo-r.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB hang
Message-ID: <20030909022236.GB4420@kroah.com>
References: <200309041951.37523.momes@mundo-r.com> <200309052332.10022.momes@mundo-r.com> <20030905213528.GA13018@kroah.com> <200309061824.51409.momes@mundo-r.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309061824.51409.momes@mundo-r.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 06, 2003 at 06:24:51PM +0200, Momes wrote:
> I've enabled CONFIG_USB_DEBUG and kernel debugging. Below are dmesg and debug 
> files, with and without noapic option.
> I've also used "nmi_watchdog=N" and  "nmi_watchdog=1" in lilo.conf with no 
> apparent result. Sorry, I don't know how to mange this feature.
> Most significant thing I've found after this are two things:
> 
> 1.- after this kernel modifications when the system boots with no USB device 
> plugged in there is no response at the moment of plug in a device. No 
> message, no hang, and device do not work.
> 
> 2.-when system is hang and press the power botton this message appears:
> "host/usb-ohci.c: USB suspend: usb-00.02.2
> host/usb-ohci.c: USB suspend: usb-00.02.3
> host/usb-ohci.c: USB continue: usb-00.02.2 from host wakeup
> host/usb-ohci.c: USB continue: usb-00.02.3 from host wakeup
> SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented
> advanced SiS pirq mapping not  yet implemented"

"suspend"?  Huh?  It's as if when you plug in your usb device, the
machine decides to power down to sleep.

Very odd, I really have no idea, sorry.

greg k-h
