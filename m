Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbUKHRP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUKHRP6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUKHROd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:14:33 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:51392 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261946AbUKHQod
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:44:33 -0500
Date: Mon, 8 Nov 2004 08:43:02 -0800
From: Larry McVoy <lm@bitmover.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: bk-commits: diff -p?
Message-ID: <20041108164302.GA489@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Larry McVoy <lm@bitmover.com>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0411080940310.27771@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411080940310.27771@anakin>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been fixed in the following releases:

bk-3.2.3
bk-3.2.2c
bk-3.2.2b

Correct usage is "bk diffs -up" which will get you unified + procedural diffs.
-p is currently a hack, it implies -u, but don't depend on that behaviour,
a future release does this correctly and if you teach your fingers that 
diffs -p is the same as diffs -up you'll get burned later.


On Mon, Nov 08, 2004 at 09:41:56AM +0100, Geert Uytterhoeven wrote:
> 	Hi Larry,
> 
> Would it be possible to enable the `-p' option (Show which C function each
> change is in) of diff for all patches sent to the bk-commits-* mailing lists?
> 
> Thanks!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
