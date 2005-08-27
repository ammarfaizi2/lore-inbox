Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbVH0UJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbVH0UJY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 16:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVH0UJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 16:09:24 -0400
Received: from smtpout1.uol.com.br ([200.221.4.192]:62359 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1750718AbVH0UJX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 16:09:23 -0400
Date: Sat, 27 Aug 2005 17:09:04 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: Fw: Oops with 2.6.13-rc6-mm2 and USB mouse
Message-ID: <20050827200904.GA4362@ime.usp.br>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Greg KH <greg@kroah.com>
References: <20050826220618.7365e690.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050826220618.7365e690.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew.

I just tested the USB mouse with 2.6.13-rc6-mm2 and ACPI disabled
(which, according to Linus, is one of the "usual suspects") and the
problem still occurred.

On the other hand, with kernel 2.6.13-rc5-mm1 (which I am running now),
I didn't have any problems plugging and unplugging the mouse. Here are
the messages I get in dmesg (2.6.13-rc5-mm1) after I plug/unplug the
mouse:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
usb 1-1.2: new low speed USB device using uhci_hcd and address 4
input: USB HID v1.00 Mouse [USB Wheel Mouse] on usb-0000:00:04.2-1.2
usb 1-1.2: USB disconnect, address 4
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Just thought you might like to know about this. If you want me to test
any other version, please let me know.


Thanks, Rogério Brito.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
