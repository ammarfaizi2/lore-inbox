Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbTATSVA>; Mon, 20 Jan 2003 13:21:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266443AbTATSVA>; Mon, 20 Jan 2003 13:21:00 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:40681 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S266438AbTATSU7>;
	Mon, 20 Jan 2003 13:20:59 -0500
Date: Mon, 20 Jan 2003 10:30:03 -0800
To: irda-users@lists.sourceforge.net,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: irport_net_open issue in 2.5.59
Message-ID: <20030120183003.GA7798@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote :
> 
> [crossposted to IrDA-users and l-k]

	Hum... This means that the IrDA mailing list archive is broken
again. Thanks SourceForge.

> The quest to set up properly (or give up where not possible) my new
> Dell Latitude C640 is moving forward... next target, IrDA. This
> laptop has a chip that is not detected by the 'findchip' tool but is
> detected by kernel code (SMC LPC47N252).

	Ok.

> When irport is loaded (or perhaps when irattach is run), the module
> complains saying
> 
> irport_net_open(), unable to allocate irq=0
> 
> It does load, but as expected it doesn't seem to work - irdadump
> doesn't come up with any line at all.

	Personally, I've never managed to make irport work, and I know
that in 2.5.X it's worse.
	But, the message above indicate that you fed the driver with
improper module options. Try to set the proper irq, that would help.
	Also, Daniele did lot's of work on the new SMC driver (smsc2,
available on my web page). Maybe you could test this one.

> Any hints ? Thanks in advance, ciao,
> 
> --alessandro

	Good luck...

	Jean

