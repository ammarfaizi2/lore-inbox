Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVCUVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVCUVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVCUVTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:19:37 -0500
Received: from witte.sonytel.be ([80.88.33.193]:18396 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261890AbVCUVRB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:17:01 -0500
Date: Mon, 21 Mar 2005 22:16:55 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 529] M68k: Update signal delivery handling
In-Reply-To: <20050321210413.GA3366@infradead.org>
Message-ID: <Pine.LNX.4.62.0503212216110.18983@numbat.sonytel.be>
References: <200503212025.j2LKPntC011301@anakin.of.borg>
 <20050321210413.GA3366@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, Christoph Hellwig wrote:
> On Mon, Mar 21, 2005 at 09:25:49PM +0100, Geert Uytterhoeven wrote:
> > M68k: Update signal delivery handling, which was broken by the removal of
> > notify_parent() in 2.6.9-rc2
> 
> After that patch the #ifndef HAVE_ARCH_GET_SIGNAL_TO_DELIVER in
> kernel/signal.c can go away now.

Unless arm26 wants to uncomment their #define HAVE_ARCH_GET_SIGNAL_TO_DELIVER
again?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
