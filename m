Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUCKBOa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 20:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbUCKBOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 20:14:30 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24068 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262931AbUCKBO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 20:14:28 -0500
Date: Thu, 11 Mar 2004 01:14:25 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Giuseppe Bilotta <bilotta78@hotpop.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer with nVidia GeForce 2 Go on Dell Inspiron 8200
In-Reply-To: <c2o8sp$h3j$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.44.0403110112170.24760-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1. The vga framebuffer works. I can even bring the monitor to 800x600 
> in tweaked VGA mode.

Cool :-) I assume you mean the vga16fb driver.

> 2. The VESA framebuffer does not work. Apparently, the card is not 
> detected as VESA-compatible. (I'm not 100% sure about this --how can 
> I check if this is indeed the case?)

Are you sure. Take a look at your vga= parmeter. What is its value?
 
> 3. The Riva framebuffer doesn't work either. It detects the video 
> card all right, understands that I'm running on a laptop and thus 
> with an LCD monitor, but as soon as I "touch" it (be it even just 
> with a fbset -i to find the information), the screen goes blank or 
> has some very funny graphical effects (fade to black in the middle, 
> etc). The system doesn't lock up (I can still blind-type and reset 
> it), but I can't use it.
> 
> Does anybody know what could be wrong?

That is a bug in fbcon layer. Now that I have my home system back up I 
plan to test my radeon card to track down the bug that was preventing the 
layer from properly resizing the screen.


