Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTDGGJy (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 02:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTDGGJy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 02:09:54 -0400
Received: from halo.ispgateway.de ([62.67.200.127]:19886 "HELO
	halo.ispgateway.de") by vger.kernel.org with SMTP id S263269AbTDGGJx (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 02:09:53 -0400
Subject: Re: USB devices in 2.5.xx do not show in /dev
From: Jens Ansorg <jens@ja-web.de>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030406201638.GC18279@kroah.com>
References: <1049632582.3405.0.camel@lisaserver>
	 <20030406201638.GC18279@kroah.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049696485.3321.16.camel@lisaserver>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 07 Apr 2003 08:21:26 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-06 at 22:16, Greg KH wrote:
> You have to have an actual device for the /dev node to show up.  Do you
> have any USB devices plugged in?  What does:
> 	tree /sys/bus/usb/
> show?
> 

yes, I have both, a scanner and a printer plugged into the computer

but there is nothing under /proc/bus/usb, it's empty

(there is no /sys/ on my PC?)


the usbview application also complains that there is no usbfs although
it gets registered by the core usb driver

drivers/usb/core/usb.c: registered new driver usbfs


everything works with 2.4.20 - so the hardware is ok


thanks
Jens

-- 
Jens Ansorg <jens@ja-web.de>

