Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVDWV6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVDWV6w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 17:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVDWV6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 17:58:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:3016 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261531AbVDWV6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 17:58:46 -0400
Date: Sat, 23 Apr 2005 23:58:29 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] swsusp: misc cleanups [0/4]
Message-ID: <20050423215829.GA1884@elf.ucw.cz>
References: <200504232320.54477.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504232320.54477.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You said you wanted something to  to try git on, so here you go. ;-)

Oops... I did not want to test it *that* badly.

Okay, here's a deal: if I say "applied" in this context, it means
"applied to my git tree". If git breaks (or if I break it), they are
gone and I'll ask you to resend (or you'll notice and resend or
whatever...)

								Pavel
> The following series of patches contains some cleanups for swsusp.c.  IMO,
> they are not very important, but at least the first two of them need to go
> at some time.
> 
> In the order of decreasing importance:
> 1/4 - move the recalculation of nr_copy_pages so that the right number is used
> 	in enough_free_mem() and enough_swap()
> 2/4 - drop the unnecessary function does_collide_order()
> 3/4 - clean up whitespace
> 4/4 - make some comments and printk()s up to date
> 
> The first three patches are against 2.6.12-rc3 and they are mutually independent.
> The last one is on top of the first three.

-- 
Boycott Kodak -- for their patent abuse against Java.
