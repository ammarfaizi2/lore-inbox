Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRAKOGp>; Thu, 11 Jan 2001 09:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRAKOGf>; Thu, 11 Jan 2001 09:06:35 -0500
Received: from zeus.kernel.org ([209.10.41.242]:36559 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130356AbRAKOG3>;
	Thu, 11 Jan 2001 09:06:29 -0500
From: "Troels Walsted Hansen" <troels@thule.no>
To: "Andrew Morton" <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] klogd busy loop on zero byte (output from 3c59x driver)
Date: Thu, 11 Jan 2001 15:06:20 +0100
Message-ID: <CKECLHEEHJOPHGPCOCKPGECDCCAA.troels@thule.no>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <3A5DA113.DC8DB21C@uow.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yep.  %02x%02x it now is.

I suppose it might be worthwhile to search the kernel sources for other
instances of printk("%c"), there's no telling when all distributions will be
up to date with new sysklogd releases...

> The code in question was snitched from pcmcia-cs's 3c575_cb.c, and
> I assume David would have heard if it was busting klogd.  Maybe
> there's a klogd version problem, or maybe your NIC's EEPROM is hosed?

I believe I have the latest version of klogd...

My NIC is a 3Com PCI 3c556 Laptop Tornado, in a Dell Latitude C600 laptop.
The driver reports the product code as "00" and the rev as "00.0", the date
however is "03-01-00" which sounds fairly reasonable (although the laptop is
brand new).

Needless to say, it also works fine, otherwise I would probably have
attacked the driver first...

--
Troels Walsted Hansen
troels@thule.no

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
