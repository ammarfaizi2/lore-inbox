Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbSLMAQ0>; Thu, 12 Dec 2002 19:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbSLMAQ0>; Thu, 12 Dec 2002 19:16:26 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40430 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S267554AbSLMAQZ>;
	Thu, 12 Dec 2002 19:16:25 -0500
Date: Thu, 12 Dec 2002 16:22:29 -0800
To: Benjamin Reed <br33d@yahoo.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Benjamin Reed <breed@users.sourceforge.net>,
       Jeff Garzik <jgarzik@mandrakesoft.com>, dahinds@users.sourceforge.net
Subject: Re: Status new-modules + 802.11b/IrDA
Message-ID: <20021213002229.GB21291@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20021212003733.2AF922C0E0@lists.samba.org> <20021212215126.96688.qmail@web20508.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021212215126.96688.qmail@web20508.mail.yahoo.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2002 at 01:51:26PM -0800, Benjamin Reed wrote:
> Sorry, I missed the original message.
> 
> As far as the timer message from airo_cs when you try
> to remove the card:  This executes some code that is
> pretty much common to all PCMCIA drivers that sets a
> timer to do the actual driver removal asynchronous to
> the REMOVAL event.  You can find it in airo_cs.c. 
> I'll update the driver.
> 
> I haven't tried the recent 2.5 kernels, so I check if
> I see anything.
> 
> ben 

	Well, I said earlier that it was a generic Pcmcia problem,
because I have the same problem with the orinoco driver. But, we need
to separate the noise from the problem (Andrew says that the timer
is only a harmless warning).
	I personally never liked the release timer, and I personally
avoided it in the wavelan_cs driver for a long time (before David
forced me to it). But, anyway at some point this will need to be
investigated.

	Have fun..

	Jean
	
