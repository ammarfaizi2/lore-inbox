Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTLMAE5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTLMAE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:04:57 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:49845 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S261332AbTLMAE4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:04:56 -0500
Subject: Re: PPP over ttyUSB (visor.o, Treo)
From: Stian Jordet <liste@jordet.nu>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031212211527.GC2002@kroah.com>
References: <20031210165540.B26394@fi.muni.cz>
	 <20031210212807.GA8784@kroah.com> <1071105744.1154.1.camel@chevrolet.hybel>
	 <1071114290.750.18.camel@chevrolet.hybel> <20031211064441.GA2529@kroah.com>
	 <1071152620.753.1.camel@chevrolet.hybel>
	 <1071154385.721.1.camel@chevrolet.hybel>  <20031212211527.GC2002@kroah.com>
Content-Type: text/plain
Message-Id: <1071273888.1379.7.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 13 Dec 2003 01:04:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 12.12.2003 kl. 22.15 skrev Greg KH:
> On Thu, Dec 11, 2003 at 03:53:06PM +0100, Stian Jordet wrote:
> > 
> > I just tried 2.4.24-pre1, and I have the same behaviour, so I guess
> > either the ftdi_sio or my mouse is b0rked. Weird, though, since they are
> > connected on two different buses, and I have four other usb devices
> > connected as well, without problem.
> I really think you are exceeding the power limits for this hub, or you
> have a flaky device.

I really understand if you are too busy answering stupid questions from
me. But I still hope someone can answer my one question.

I have six usb-devices: 3com Bluetooth, HP printer, Epson scanner,
Logitech keyboard/mouse, Kodak digital camera and a no-name memory card
reader. My motherboard have six onboard usb-ports.

The problem _only_ occur when I have a ppp-connection through the
ftdi_sio adapter. I tried disconnecting everything except the usb-serial
adapter and the Logitech. Same problem. Without an active
ppp-connection. No problems what-so-ever.

If I use a PS/2 keyboard and mouse, no problems with the rest of the usb
devices, even with a ppp connection.

Can my usb-serial converter be the flaky device, even though it's the
Logitech that is complaining, or can it be the motherboard? Since I
never-ever saw any error messages untill I recently switched my pl2303
against the ftdi_sio.

Best regards,
Stian

