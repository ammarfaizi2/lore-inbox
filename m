Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756589AbWKSLxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589AbWKSLxN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 06:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756592AbWKSLxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 06:53:12 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:24502 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S1756589AbWKSLxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 06:53:11 -0500
Date: Sun, 19 Nov 2006 12:53:10 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Bunk <bunk@stusta.de>
cc: Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       funaho@jurai.org, Linux/m68k on Mac <linux-mac68k@mac.linux-m68k.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>, jejb@steeleye.com,
       Roman Zippel <zippel@linux-m68k.org>,
       Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC: 2.6 patch] remove broken net drivers
In-Reply-To: <20061118000224.GU31879@stusta.de>
Message-ID: <Pine.LNX.4.62.0611191249450.31733@pademelon.sonytel.be>
References: <20061118000224.GU31879@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Nov 2006, Adrian Bunk wrote:
> This patch removes net drivers that:
> - had already been marked as BROKEN in 2.6.0 three years ago and
> - are still marked as BROKEN.
> 
> These are the following drivers:
> - MAC89x0

I still have a patch lying around for this one:

http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/POSTPONED/357-mac89x0.diff

I don't remember 100% why I put it in my POSTPONED queue. Maybe because it was
rejected upstream?

If it's OK (it compiles fine with 2.6.19-rc5), please tell me, and I'll
resubmit it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
