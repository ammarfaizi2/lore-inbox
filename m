Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVC1WXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVC1WXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 17:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVC1WXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 17:23:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9358 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262094AbVC1WXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 17:23:05 -0500
Date: Tue, 29 Mar 2005 00:22:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] sparsemem intro patches
Message-ID: <20050328222251.GF1389@elf.ucw.cz>
References: <1110834883.19340.47.camel@localhost> <20050319193345.GE1504@openzaurus.ucw.cz> <1112045005.2087.38.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112045005.2087.38.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Three of these are i386-only, but one of them reorganizes the macros
> > > used to manage the space in page->flags, and will affect all platforms.
> > > There are analogous patches to the i386 ones for ppc64, ia64, and
> > > x86_64, but those will be submitted by the normal arch maintainers.
> > > 
> > > The combination of the four patches has been test-booted on a variety of
> > > i386 hardware, and compiled for ppc64, i386, and x86-64 with about 17
> > > different .configs.  It's also been runtime-tested on ia64 configs (with
> > > more patches on top).
> > 
> > Could you try swsusp on i386, too?
> 
> Runtime, or just compiling?  
> 
> Have you noticed a real problem?

I'd prefer runtime, but.... No, I did not notice anything, but in past
we have some "interesting" problems with discontigmem... and this
looks similar.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
