Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTL2PQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263537AbTL2PQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 10:16:32 -0500
Received: from [193.138.115.2] ([193.138.115.2]:13832 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263545AbTL2PQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 10:16:30 -0500
Date: Mon, 29 Dec 2003 16:13:50 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Paul Misner <paul@misner.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Blank Screen in 2.6.0
In-Reply-To: <200312290022.14411.paul@misner.org>
Message-ID: <Pine.LNX.4.56.0312291610060.1041@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.44.0312281806070.3217-200000@eglifamily.dnsalias.net>
 <200312290022.14411.paul@misner.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Dec 2003, Paul Misner wrote:

> On Sunday 28 December 2003 12:14 pm, dan@eglifamily.dnsalias.net wrote:
> > Ok. After being without power for the past few days due to record
> > snowfall, I'm alive again. So I made the changes people had recomended on
> > the list. Upgraded to the lastest module-init-tools, and disabled the
> > frame buffer support in the kernel. So the only graphic option enabled is
> > text mode selection. But when I boot I still get a blank screen!
> >
> > My lilo.conf contains a line: vga=773, which works beautifully under
> > RedHat's stock 2.4.20-8. I get a nice screen with approximately 132x48
> > display. Under 2.4.20 I am not loading any frame buffer that I'm aware of.
> > It's not listed in my moduiles:
> >
>
> Just a suggestion, but why not use vga=normal, which is text mode, instead of
> graphics.  You don't get the boot logo, but it does give you all the boot
> messages on 80x24.  I have been having the same issues, with an Nvidia card,
> and I decided it wasn't worth spending any time on it, since I really just
> wanted to see the messages, not any pictures.

I've found that using "rivafb" does not work with my Geforce3, and from
talking to various people on IRC about it I get the impression that rivafb
is broken for any card newer than Geforce2. "vesafb" though works quite
well with never NVidia cards.

If I build my kernels with "rivafb" enabled I get a blank screen as well,
but using "vesafb" all is fine (so is just plain vga=normal or
vga=extended, but I prefer the fb console :)


Just my 0.02 euro


/ Jesper Juhl

