Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVCRJbG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVCRJbG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVCRJbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:31:05 -0500
Received: from web25103.mail.ukl.yahoo.com ([217.12.10.51]:38750 "HELO
	web25103.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261546AbVCRJal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:30:41 -0500
Message-ID: <20050318093037.36721.qmail@web25103.mail.ukl.yahoo.com>
Date: Fri, 18 Mar 2005 10:30:37 +0100 (CET)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: [UART] 8250:RTS/CTS flow control issue.
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> If you want it to be immediate, then I'm afraid
> you're going to have a
> relatively hard time, with compatibility problems
> with various systems.
> You can't really dictate to people that they must
> turn off the FIFOs on
> their UARTs for your product to work.  (Well, you
> can, but _you_ would
> have to support them.)
> 

well, I don't specially wan't to be immediate.
My hardware has "auto flow control" and a 8 bytes
fifo...So *whatever* the trigger level is for RTS
(actually I can't tune it), I will overrun because 
the end *driver*, which should be aware of the lack of
its "hw auto flow control", decides to fill up its tx
fifo to 8 bytes when transmiting...

One other solution may be to give the possibility of
the user to tune the size of tx fifo ?

thanks

      Francis


	

	
		
Découvrez nos promotions exclusives "destination de la Tunisie, du Maroc, des Baléares et la Rép. Dominicaine sur Yahoo! Voyages :
http://fr.travel.yahoo.com/promotions/mar14.html
