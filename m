Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265413AbTGCV7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 17:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265415AbTGCV7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 17:59:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1408 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265413AbTGCV7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 17:59:09 -0400
Date: Thu, 3 Jul 2003 15:12:18 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Russell King <rmk@arm.linux.org.uk>
cc: Johoho <johoho@hojo-net.de>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.74-mm1
In-Reply-To: <20030703225338.F20336@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0307031457560.983-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > ChangeSet@1.1348.20.5, 2003-06-23 23:52:55+01:00,
> > rmk@flint.arm.linux.org.uk
> >   [SERIAL] 8250_cs update - incorporate pcmcia-cs 3.1.34 serial_cs fixes
> 
> -rc2 or -bk2?
> 
> Hmm.  That's actually the 3rd of a set of 3 csets which only touch
> 8250_cs.c.  If you aren't using a card with a serial port built in
> (eg, modem) then these csets shouldn't make any difference to you.

Actually, at least in my case, mine is a combo modem/network card: D-Link 
DMF-560TXD. Sorry, shoulda mentioned that in the first place. 

I didn't initially have CONFIG_SERIAL_8250_CS enabled, but enabling it
doesn't change behavior.


	-pat

