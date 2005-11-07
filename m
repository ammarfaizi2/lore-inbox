Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVKGMl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVKGMl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 07:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVKGMl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 07:41:59 -0500
Received: from witte.sonytel.be ([80.88.33.193]:2207 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S932456AbVKGMl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 07:41:59 -0500
Date: Mon, 7 Nov 2005 13:41:51 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-mm1
In-Reply-To: <20051107033009.GB12192@infradead.org>
Message-ID: <Pine.LNX.4.62.0511071339020.11130@numbat.sonytel.be>
References: <20051106182447.5f571a46.akpm@osdl.org> <20051107033009.GB12192@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2005, Christoph Hellwig wrote:
> > -m68k-introduce-task_thread_info.patch
> > -m68k-introduce-setup_thread_stack-end_of_stack.patch
> > -m68k-thread_info-header-cleanup.patch
> > -m68k-m68k-specific-thread_info-changes.patch
> > -m68k-convert-thread-flags-to-use-bit-fields.patch
> > -add-stack-field-to-task_struct.patch
> > -add-stack-field-to-task_struct-ia64-fix.patch
> > -rename-allocfree_thread_info-to-allocfree_thread_stack.patch
> > -use-end_of_stack.patch
> > -change-thread_info-access-to-stack.patch
> > -use-task_thread_info.patch
> > 
> >  Dropped - the powerpc changes broke these and they probably need some
> >  separating out anyway.
> 
> gosh.  Can we please get one of the patches to allow m68k in mainline
> merged?  roman has been blocking these since 2.6.13 at least.  Alternatively
> just kill m68k from mainline due to lack of active maintainer.

Christoph, some of these patches are from Al Viro, some are from Roman Zippel.
But all of them are signed-off-by Roman, so I don't see how Roman is blocking
them (Unless you really mean the hurry up to get them in 2.6.13-final)...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
