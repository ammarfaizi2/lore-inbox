Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130579AbRBCVTx>; Sat, 3 Feb 2001 16:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130132AbRBCVTn>; Sat, 3 Feb 2001 16:19:43 -0500
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:11675 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S130576AbRBCVTe>; Sat, 3 Feb 2001 16:19:34 -0500
Message-ID: <3A7C7756.EA5778DB@didntduck.org>
Date: Sat, 03 Feb 2001 16:25:42 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Viktor Rosenfeld <rosenfel@informatik.hu-berlin.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] ISA-PnP and 3c509 NIC won't work together
In-Reply-To: <3A7C45E4.15C470A3@informatik.hu-berlin.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Viktor Rosenfeld wrote:
> 
> Hi kernel hackers,
> 
> I have troubles getting both ISA-PnP and the driver for my 3c509 NIC
> working together.  
> 
> I can only get my NIC to work when I leave ISA-PnP completely out of the
> kernel.  When I have ISA-PnP activated, the card will not show up in
> /proc/isapnp (see below) nor is it listed in the table that my system
> displays prior to starting LILO.  The kernel help on the 3c509 driver
> suggests to completely deactivate PNP for the NIC, which is what I have
> done since kernel 2.0.x.  Unfortunately, I can't find info on
> re-enabling PNP on the card.
> 
> Below, I have attached the content of /proc/isapnp.  If I can do
> anything to provide more info, let me know.

Go to 3Com's site and get the setup program for the card (for DOS).  It
is configurable via eeprom for io and irq or PnP mode.

--
					Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
