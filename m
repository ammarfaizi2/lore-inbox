Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWIMSrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWIMSrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWIMSrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:47:04 -0400
Received: from witte.sonytel.be ([80.88.33.193]:37343 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S1751103AbWIMSrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:47:02 -0400
Date: Wed, 13 Sep 2006 20:38:59 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Howells <dhowells@redhat.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>,
       Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel 
In-Reply-To: <4143.1158166615@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.62.0609132038350.27940@pademelon.sonytel.be>
References: <20060913163806.GA15563@flint.arm.linux.org.uk>
 <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com>
 <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com>
 <20060913161734.GE3564@stusta.de> <20060913163136.GA2585@parisc-linux.org>
  <4143.1158166615@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, David Howells wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> 
> > Therefore, re-using "log2()" is about as bad as re-using the "strcmp()"
> > name to implement a function which copies strings.
> 
> I should probably use ilog2() then which would at least be consistent with the
> powerpc arch.
> 
> > t.c:2: warning: conflicting types for built-in function 'log2'

And apparently gcc < 4.0 doesn't give the warning.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
