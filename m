Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266311AbUGOTt5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266311AbUGOTt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266317AbUGOTt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:49:56 -0400
Received: from albireo.ucw.cz ([81.27.203.89]:23171 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S266311AbUGOTtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:49:51 -0400
Date: Thu, 15 Jul 2004 21:49:51 +0200
From: Martin Mares <mj@ucw.cz>
To: "Max T. Woodbury" <max.teneyck.woodbury@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI configuration changes getting lost.
Message-ID: <20040715194951.GA4950@ucw.cz>
References: <40F693EE.5D65D02F@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40F693EE.5D65D02F@verizon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The BIOS puts junk (0xFF) in the INTERRUPT_LINE register of the PCMCIA
> configuration registers.  I can put the correct value (0x05) in with
> 'setpci', but the information is not propagated to the /proc space.
> The information is not preserved after an 'init 6'.

The INTERRUPT_LINE register doesn't affect interrupt routing a single bit,
it's merely a scratch pad register used for passing the interrupt
number from BIOS to the drivers (or Linux kernel in this case).

BTW which kernel do you use?

What do the boot-up messages say?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
Lottery -- a tax on people who can't do math.
