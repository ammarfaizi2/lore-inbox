Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbTLQAhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 19:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLQAhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 19:37:12 -0500
Received: from smtp02.ya.com ([62.151.11.132]:37613 "EHLO smtp.ya.com")
	by vger.kernel.org with ESMTP id S262129AbTLQAhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 19:37:10 -0500
Subject: Re: UHCI-HCD && mosedev on 2.6.0-test11
From: Carlos =?ISO-8859-1?Q?Jim=E9nez?= <lordeath@linuxspain.net>
Reply-To: lordeath@linuxspain.net
To: Greg KH <greg@kroah.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031216174639.GD2716@kroah.com>
References: <1071536070.12406.5.camel@localhost>
	 <20031216174639.GD2716@kroah.com>
Content-Type: text/plain; charset=iso-8859-15
Organization: Torrejon Wireless
Message-Id: <1071621227.11193.69.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Dec 2003 01:33:48 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok thanx I'll try it, and i'll notify you

Excuse my english (I am from spain, and I not practice english too much
:)

On 2.6.0-alltest (not yet probed with bk) all usb devices works good
(usb-storage with an aiptek cam, and usbfloppy).

When I plug in that mouse, usbview shows it as an unrecognized device.
The device does not work at all, cat /dev/input/mice , cat
/dev/input/mouse0 and cat /dev/usbmouse shows anything when I move the
usbmouse, (on 2.4.2x kernel device works good, and I was wathcing ascii
characters, when I  was moving it).

Then, when I removed the device, or when i try to unload uhci-hcd (while
device is plugged) kernel show that info, and all about usb goes down. I
cant unload, load, anything about modules, and I have to use sync before
poweroff to power off the system whithout breakin filesystems.

thank you for all. I'll try bk tree to see if this error is yet fixed on
it.

El mar, 16-12-2003 a las 18:46, Greg KH escribió:
> On Tue, Dec 16, 2003 at 01:55:34AM +0100, Carlos Jiménez wrote:
> > Hello,
> > 
> > I have an usbmouse that works on 2.4.x kernel series.
> > now on 2.6.0 usb module hangs, and does not work with it.
> 
> Did this happen when you removed the device?  Can you try the latest -bk
> tree?  There have been a number of fixes that will hopefully fix this
> problem for you.
> 
> thanks,
> 
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

