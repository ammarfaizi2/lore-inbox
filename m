Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269469AbUJFUtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269469AbUJFUtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269474AbUJFUro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:47:44 -0400
Received: from witte.sonytel.be ([80.88.33.193]:45213 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269469AbUJFUiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:38:01 -0400
Date: Wed, 6 Oct 2004 22:37:20 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to
 10ms)
In-Reply-To: <41644E6B.5070607@pobox.com>
Message-ID: <Pine.GSO.4.61.0410062231290.738@waterleaf.sonytel.be>
References: <200410060042.i960gn631637@unix-os.sc.intel.com>
 <20041005205511.7746625f.akpm@osdl.org> <416374D5.50200@yahoo.com.au>
 <20041005215116.3b0bd028.akpm@osdl.org> <41637BD5.7090001@yahoo.com.au>
 <20041005220954.0602fba8.akpm@osdl.org> <416380D7.9020306@yahoo.com.au>
 <20041005223307.375597ee.akpm@osdl.org> <41638E61.9000004@pobox.com>
 <20041005233958.522972a9.akpm@osdl.org> <41644A3D.4050100@pobox.com>
 <41644BF1.7030904@pobox.com> <41644E6B.5070607@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Jeff Garzik wrote:
> Jeff Garzik wrote:
> > So my own suggestions for increasing 2.6.x stability are:
> 
> And one more, that I meant to include in the last email,
> 
> 3) Release early, release often (official -rc releases, not just snapshots)

I guess you mean official -pre releases as well?

Gr{oetje,eeting}s,

						Geert

P.S. I only track `real' (-pre and -rc) releases. I don't have the manpower
     (what's in a word) to track daily snapshots (I do `read' bk-commits). If
     m68k stuff gets broken in -rc, usually it means it won't get fixed before
     2 full releases later.  Anyway, things shouldn't become broken in -rc,
     IMHO that's what we (should) have -pre for...
--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
