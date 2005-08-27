Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbVH0Wdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbVH0Wdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 18:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbVH0Wdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 18:33:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750727AbVH0Wdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 18:33:38 -0400
Date: Sat, 27 Aug 2005 15:31:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?B?Um9n6XJpbw==?= Brito <rbrito@ime.usp.br>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: Fw: Oops with 2.6.13-rc6-mm2 and USB mouse
Message-Id: <20050827153157.47ac39d2.akpm@osdl.org>
In-Reply-To: <20050827200904.GA4362@ime.usp.br>
References: <20050826220618.7365e690.akpm@osdl.org>
	<20050827200904.GA4362@ime.usp.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogério Brito <rbrito@ime.usp.br> wrote:
>
> Hi, Andrew.
> 
> I just tested the USB mouse with 2.6.13-rc6-mm2 and ACPI disabled
> (which, according to Linus, is one of the "usual suspects") and the
> problem still occurred.
> 
> On the other hand, with kernel 2.6.13-rc5-mm1 (which I am running now),
> I didn't have any problems plugging and unplugging the mouse. Here are
> the messages I get in dmesg (2.6.13-rc5-mm1) after I plug/unplug the
> mouse:
> 
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> usb 1-1.2: new low speed USB device using uhci_hcd and address 4
> input: USB HID v1.00 Mouse [USB Wheel Mouse] on usb-0000:00:04.2-1.2
> usb 1-1.2: USB disconnect, address 4
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> 
> Just thought you might like to know about this. If you want me to test
> any other version, please let me know.
> 

Unfortunately there are 71 USB patches in 2.6.13-rc6-mm2 and I don't know
which ones to suspect.

Hopefully Greg (when he returns) or one of the other USB developers can
identify the buggy patch - we wouldn't want this leaking into Linus's
kernel..
