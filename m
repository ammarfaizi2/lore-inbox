Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261430AbVAaXZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261430AbVAaXZP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVAaXZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:25:15 -0500
Received: from gate.crashing.org ([63.228.1.57]:4264 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261430AbVAaXRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:17:05 -0500
Subject: Re: Fw: Re: 2.6.11-rc2-mm2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean Neakums <sneakums@zork.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <6uekg254vp.fsf@zork.zork.net>
References: <20050129163117.1626d404.akpm@osdl.org>
	 <1107155510.5905.2.camel@gaston>  <6uekg254vp.fsf@zork.zork.net>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 10:16:47 +1100
Message-Id: <1107213408.5906.23.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 09:23 +0000, Sean Neakums wrote:

> Not to worry.  I only ended up with modular radeonfb when I was trying
> to narrow down the cause of the boot hang.
> 
> [...]
> > radeonfb built-in operations seem to be ok on my PowerBook3,5 (ATI M9
> > based), I'll try on a PowerBook5,4 (same as yours) tomorrow hopefully.
> >
> > Does the machine hang with the screen completely cleared ? Do you see
> > the penguin logo ? Did you try just using pmac_defconfig ?
> 
> I seem some openpic messages and then the screen is cleared
> completely.  Alas, I have the logo disabled in my configuration.  I'll
> give pmac_defconfig a go this evening.
> 
> I forgot to mention, after radeonfb failed to load as above, I fired
> up X.  The display was unreadably corrupted, although the hardware
> cursor was fine and I could launch programs.  Killing the X server did
> not return me to the console.  I neglected to check if the machine was
> still accessible via the network.

X tend to be upset on macs if radeonfb hasn't pre-initialized the chip.
I think I fixed all of these problems in Xorg CVS tho.

Ben.


