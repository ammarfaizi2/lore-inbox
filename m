Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283585AbRL1AVp>; Thu, 27 Dec 2001 19:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283311AbRL1AVe>; Thu, 27 Dec 2001 19:21:34 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:61137 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S283618AbRL1AVQ>; Thu, 27 Dec 2001 19:21:16 -0500
Date: Thu, 27 Dec 2001 15:22:48 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] [PATCH] current state of the 2.5.1 USB tree
To: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Message-id: <061101c18f35$5e141e60$6800000a@brownell.org>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
In-Reply-To: <20011219104253.A11032@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A patch against a clean 2.5.1 tree is at:
> http://www.kroah.com/linux/usb/linux-2.5.1-gregkh-1.patch.gz
> 
> This patch contains 5 new USB drivers (stv680, vidcam, ipaq, kl5kusb105,
> and the usb 2.0 ehci-hcd driver), documentation for all of these new
> drivers, a rewrite of usbdevfs/usbfs, and lots of other smaller fixes
> and changes.

By the way -- if folk need to see EHCI (60 MByte/sec USB) on 2.4,
drop a line.  The code is in CVS, and clearly most of that development
was done on the 2.4 kernel.  A number of folk are using that code with
success on those highspeed USB storage devices.

But most of the USB 2.0 work will be done in the 2.5 tree, so that's
going to be the place to watch!

- Dave



