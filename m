Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUCKLAP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 06:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUCKLAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 06:00:15 -0500
Received: from main.gmane.org ([80.91.224.249]:32901 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261171AbUCKLAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 06:00:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
Date: Thu, 11 Mar 2004 11:51:08 +0100
Message-ID: <MPG.1aba630ad806a4c3989683@news.gmane.org>
References: <c2o8sp$h3j$1@sea.gmane.org> <Pine.LNX.4.44.0403110112170.24760-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> 
> > 1. The vga framebuffer works. I can even bring the monitor to 800x600 
> > in tweaked VGA mode.
> 
> Cool :-) I assume you mean the vga16fb driver.

Yes :)

> > 2. The VESA framebuffer does not work. Apparently, the card is not 
> > detected as VESA-compatible. (I'm not 100% sure about this --how can 
> > I check if this is indeed the case?)
> 
> Are you sure. Take a look at your vga= parmeter. What is its value?

I tried vga=ask, and no VESA modes are detected.

> > 3. The Riva framebuffer doesn't work either. It detects the video 
> > card all right, understands that I'm running on a laptop and thus 
> > with an LCD monitor, but as soon as I "touch" it (be it even just 
> > with a fbset -i to find the information), the screen goes blank or 
> > has some very funny graphical effects (fade to black in the middle, 
> > etc). The system doesn't lock up (I can still blind-type and reset 
> > it), but I can't use it.
> > 
> > Does anybody know what could be wrong?
> 
> That is a bug in fbcon layer. Now that I have my home system back up I 
> plan to test my radeon card to track down the bug that was preventing the 
> layer from properly resizing the screen.

Is there a particular reason why it would blank out even when just 
asking for information, without changing any setting?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

