Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWBNWUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWBNWUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 17:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422834AbWBNWUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 17:20:19 -0500
Received: from gate.crashing.org ([63.228.1.57]:46237 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1422829AbWBNWUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 17:20:18 -0500
Subject: Re: HELP: Problem with radeonfb setting wrong resolution
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timothy Miller <theosib@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
References: <9871ee5f0602141233t3cf11775lcb6351f31d4f377e@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 15 Feb 2006 09:20:12 +1100
Message-Id: <1139955612.7903.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 15:33 -0500, Timothy Miller wrote:
> I humbly apologize if it is inappropriate for me to post this question
> here.  I'm not subscribed, and I haven't been in a while.  I've
> googled around for answers to this, but I don't find anything that
> directly addresses the issue I'm seeing.  Please cc me.
> 
> I'm installing a new Gentoo box, and I have configured the
> 2.6.12-gentoo-r6 kernel.
> 
> Here's what I have enabled:
> 
> + Support for framebuffer devices
> + ATI Radeon display support
> + DDC/I2C for ATI Radeon support
> + Lots of debug output from Radeon drive
> + VGA text console
> + Framebuffer Console support
> 
> In the grub.conf file, I have this at the end of the kernel line:
> 
> video=radeonfb:1024x768
> 
> When booting up, radeonfb finds the device (A Radeon 7000 PCI card),
> the monitor flickers for a second, and then what I get is a 640x480
> screen, but the kernel seems to think it's 1024x768, because text goes
> off the screen.
> 
> I've googled for this, but what I find is old stuff where people are
> complaining about seeing a higher resolution than the one they asked
> for.  I'm getting a LOWER resolution.
> 
> I can't figure out what I'm doing wrong, but there are no kernel error
> messages that tell me anything has gone wrong.
> 
> Can anyone help me figure out what I'm doing wrong here?  BTW, the
> monitor is a 19" NEC.  No chance that the monitor reports via DDC that
> it can't do 1024x768.

Can you send me the debug output ? (dmesg)

Ben.


