Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTDTJrS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 05:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263551AbTDTJrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 05:47:18 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:4534 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id S263549AbTDTJrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 05:47:17 -0400
Date: Sun, 20 Apr 2003 11:58:30 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Shachar Shemesh <lkml@shemesh.biz>
cc: Ben Collins <bcollins@debian.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
In-Reply-To: <3EA24CF8.5080609@shemesh.biz>
Message-ID: <Pine.GSO.4.21.0304201157280.14680-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Shachar Shemesh wrote:
> Ben Collins wrote:
> >I hate asking this on top of the work you already provide, but would it
> >be possible to allow rsync access to the repo itself? I have atleast 6
> >computers on my LAN where I keep source trees (2.4 and 2.5), and it
> >would be much less b/w on my metered T1 and on your link aswell if I
> >could rsync one main "mirror" of the cvs repo and then point all my
> >machines at it.
> >
> There is a better tool (for this particular task), called "cvsup". It 
> does a wonderful job of keeping cvs repositories in synch. I realize I 
> just asked for a THIRD tool, so it should only go in if the admins are 
> willing to take care of it.
> 
> The idea is that it uses the full duplexity of the channel to get client 
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> side information about the repository on that end while downloading 
> changes, thus increasing the effective bandwidth. It only falls back to 

What does this mean for asymmetric links (ADSL or cable)?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

