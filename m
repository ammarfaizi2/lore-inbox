Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbTHYPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbTHYPl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:41:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:7101 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262012AbTHYPlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:41:37 -0400
Date: Mon, 25 Aug 2003 08:47:16 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Russell King <rmk@arm.linux.org.uk>
cc: Pavel Machek <pavel@ucw.cz>, <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Patrick: which part of "maintainer" and "peer review" needs
 explaining to you?
In-Reply-To: <20030823114738.B25729@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0308250840360.1157-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a hell of a lot of work which now needs to be done to re-fix
> everything which was working.  For example, there is no sign of any
> power management for platform devices currently.  Could you give some
> clues as to what you'd like to see there?

How about following the system device scheme: 1 call, with interrupts 
disabled? 

> There's also a fair number of drivers to update to this new power
> management model - eg, ARM device drivers, PCMCIA socket drivers to
> name just two.

That's fine. I will fix PCMCIA, as I have devices to test with. I have no 
ARM devices (nor do I want any). I can take a stab, but won't guarantee 
anything. Could you tell me, though, when/if these devices did work with 
what power management scheme? APM? 

> We also need to fix the device model probing so we can have a generic
> PCI bridge driver but override it if we have a more specific driver.

We talked about that, and it's going to require some changes to the core, 
albeit small. We're not prepared to do that right now, though we'll 
reconsider depending on necessity and impact of the patch.. 


	Pat

