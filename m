Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbULHSut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbULHSut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbULHSut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 13:50:49 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:7 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S261292AbULHSuj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 13:50:39 -0500
Subject: Re: internal card reader support
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Felix Dorner <felix_do@web.de>
Cc: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
In-Reply-To: <41B74174.3080908@web.de>
References: <41B74174.3080908@web.de>
Content-Type: text/plain
Date: Wed, 08 Dec 2004 19:50:34 +0100
Message-Id: <1102531834.4272.12.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 18:01 +0000, Felix Dorner wrote:
> Hi,
> 
> 
> My notebook (hp nx9105) has an integrated 5in1 card-reader. I would 
> really like to use this with linux.
> Since I do not think it is supported yet, I d like to know if it might 
> be possible to write a module or so for this.
> I am just an average C programmer, but always wanted to dive into kernel 
> developement. My knowledge on computer architecture is also no more than 
> basic, so this might be something to really learn a lot...
> So I start at zero knowledge now. First of course I need to find out if  
> what I want to do is possible at all.
> This means now to identify the hardware inside and see if I can get 
> documents for that.
> 
> First I just start with:
> 
> #lspci
> [...]
> 0000:02:04.0 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
> 0000:02:04.1 CardBus bridge: Texas Instruments: Unknown device ac54 (rev 01)
> 0000:02:04.2 System peripheral: Texas Instruments: Unknown device 8201 
> (rev 01)
> [...]

Looks like the card reader is part of the PC Card chip. I have a similar
setup om my laptop. I never managed to get it working. But maybe things
changed and newer PC Card brigdes have a card reader which act as a USB
device. I have a Ricoh controller on my laptop:

00:09.0 CardBus bridge: Ricoh Co Ltfd RL5c476 II (rev 88)
00:09.1 CardBus bridge: Ricoh Co Ltfd RL5c476 II (rev 88)
00:09.2 System peripheral: Ricoh Co Ltd: Unknown device 0576 (SD Card
reader?)

> This is all that I have. Now I am already confused. My box has one 
> PCMCIA slot. Which is now the PCMCIA and which is the CardReader? What 
> about the third device? Might this be the integrated infrared controller?
> 
> Can you give me any hints/tips where to start best, what to read first?
> 
> I know this seems to be very difficult, but I have quite some free time 
> that I don't want to spend playing bzflag all night long, so I think 
> this is a great way to learn something.
> 
Jurgen


