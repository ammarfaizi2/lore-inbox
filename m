Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUKCH6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUKCH6s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 02:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbUKCH6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 02:58:48 -0500
Received: from krynn.se.axis.com ([193.13.178.10]:35223 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S261459AbUKCH6m convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 02:58:42 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: "'Christoph Hellwig'" <hch@infradead.org>,
       "Mikael Starvik" <mikael.starvik@axis.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: RE: [PATCH 8/10] CRIS architecture update - Move drivers
Date: Wed, 3 Nov 2004 08:57:59 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C7498@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66801AF748D@exmail1.se.axis.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/ethernet and drivers/ide there already are directories for e.g.
arm and ppc so I would like to add cris in the same way. I agree that the
v10 subdirectories are unnecessary, I'll remove them. Under serial and
usb/host there are no such subdirs so I will store the drivers directly
under those dirs.

Expect new patches tomorrow.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Christoph Hellwig
Sent: Tuesday, November 02, 2004 11:56 PM
To: Mikael Starvik
Cc: linux-kernel@vger.kernel.org; akpm@osdl.org
Subject: Re: [PATCH 8/10] CRIS architecture update - Move drivers


On Tue, Nov 02, 2004 at 02:04:51PM +0100, Mikael Starvik wrote:
> This is a shell script to move drivers from arch/cris/arch-v10/drivers to
> e.g. drivers/net/cris/v10. This must be applied after patch 1-7 and before
> patch 9.
> 
> Let me know if you prefer this as a big diff instead.

Given that you have only a handfull drivers those subdirectories don't
make sense.  Just give the drivers sane names and move them directly
to the appropinquate directories under drivers/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

