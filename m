Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbTEEUgy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbTEEUgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:36:54 -0400
Received: from sunpizz1.rvs.uni-bielefeld.de ([129.70.123.31]:129 "EHLO
	mail.rvs.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id S261272AbTEEUgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:36:53 -0400
Subject: Re: [PATCH] 2.5.69 : drivers/bluetooth/hci_usb.c
From: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
To: Frank Davis <fdavis@si.rr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0305051642060.18736-100000@master>
References: <Pine.LNX.4.44.0305051642060.18736-100000@master>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 05 May 2003 22:48:43 +0200
Message-Id: <1052167729.16216.8.camel@pegasus.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

> The following patch addresses the compile error below (I haven't seent 
> this previously reported.). I suspect there's a cleaner patch. Please review. Thanks.
> 
> drivers/bluetooth/hci_usb.c: In function `hci_usb_send_bulk':
> drivers/bluetooth/hci_usb.c:461: `USB_ZERO_PACKET' undeclared (first use in this function)
> drivers/bluetooth/hci_usb.c:461: (Each undeclared identifier is reported only once
> drivers/bluetooth/hci_usb.c:461: for each function it appears in.)
> make[2]: *** [drivers/bluetooth/hci_usb.o] Error 1
> make[1]: *** [drivers/bluetooth] Error 2
> make: *** [drivers] Error 2

this was already reported by Grzegorz Jaskiewicz for 2.5.68-bk10 and I
have fixed it in my repositories. See mailing list archive for the
patch.

Regards

Marcel


