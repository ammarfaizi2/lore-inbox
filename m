Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUBHPUF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 10:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbUBHPUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 10:20:05 -0500
Received: from witte.sonytel.be ([80.88.33.193]:20723 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S263544AbUBHPUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 10:20:01 -0500
Date: Sun, 8 Feb 2004 16:18:41 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
In-Reply-To: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
Message-ID: <Pine.GSO.4.58.0402081217280.1034@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Feb 2004, Linus Torvalds wrote:
> There's a lot of network driver updates (have been in -mm and Jeff's
> testing trees for a while), and Al Viro has been fixing up not just
> network drivers, but also cursing over parport interfaces ;)

Now I get this compiler warning:
| drivers/net/Space.c:329: warning: value computed is not used

And now these are in, I can finally send the 4 patches to convert the Amiga
Ethernet drivers to the new driver model. Stay tuned...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
