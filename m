Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVDUJKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVDUJKd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 05:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDUJKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 05:10:31 -0400
Received: from witte.sonytel.be ([80.88.33.193]:9878 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261222AbVDUJKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 05:10:18 -0400
Date: Thu, 21 Apr 2005 11:10:15 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jan Dittmer <jdittmer@ppp0.net>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux/m68k <linux-m68k@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
In-Reply-To: <42676B76.4010903@ppp0.net>
Message-ID: <Pine.LNX.4.62.0504211105550.13231@numbat.sonytel.be>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org>
 <42676B76.4010903@ppp0.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2005, Jan Dittmer wrote:
> Linus Torvalds wrote:
> > Geert Uytterhoeven:
> >     [PATCH] M68k: Update defconfigs for 2.6.11
> >     [PATCH] M68k: Update defconfigs for 2.6.12-rc2
> 
> Why do I still get this error when trying to cross-compile for m68k?

Because to build m68k kernels, you (still :-( have to use the Linux/m68k CVS
repository, cfr. http://linux-m68k-cvs.ubb.ca/.

BTW, my patch queue is at
http://linux-m68k-cvs.ubb.ca/~geert/linux-m68k-2.6.x-merging/.
The main offender is POSTPONED/156-thread_info.diff.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
