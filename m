Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVAaXTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVAaXTy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVAaXTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:19:51 -0500
Received: from gate.crashing.org ([63.228.1.57]:6568 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261428AbVAaXSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:18:52 -0500
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joseph Fannin <jfannin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Sean Neakums <sneakums@zork.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131112106.GA3494@samarkand.rivenstone.net>
References: <20050129163117.1626d404.akpm@osdl.org>
	 <1107155510.5905.2.camel@gaston>
	 <20050131112106.GA3494@samarkand.rivenstone.net>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 10:18:33 +1100
Message-Id: <1107213513.5963.26.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 06:21 -0500, Joseph Fannin wrote:

>     I'm getting a blank screen with radeonfb on two boxes here as
> well. One is a beige g3, the other is i386; both have PCI Radeon 7000s
> with radeonfb non-modular. 
> 
>     On the PC I could see the earliest kernel messages in VGA text
> mode before radeonfb took over and the screen went blank -- no
> penguin, and the logo is enabled.  Booting with radeonfb:off seemed to
> work except for the module problem in -rc2-mm2:
> 
>     On the ppc box I tried both -rc2-mm1 and -rc2-mm2.  Both hung and
> then rebooted after 3 minutes, so it seems to be panicing somewhere.
> I backed the massive-radeonfb patch out of -mm2 and radeonfb worked,
> so I got as far as the module thing again.
> 
>     So yeah, it's possible that there's something in -mm1 that panics
> my ppc, and radeonfb is just making a blank screen, but it seems more
> likely that radeonfb is panicing.  I tried to get netconsole working
> on both machines, but it didn't work out for unrelated reasons.
> 
>     Hopefully I'll have more time to poke at this tomorrow; maybe this
> is helpful somehow.

Hrm... indeed, there seem to be a problem, though I can't tell for sure
what's up now, it just works on all the configs I had a chance to test
on. Can you try to boot your G3 with serial console so you can see the
panic message if any ?

Ben.


