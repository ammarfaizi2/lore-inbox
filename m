Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUH2QhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUH2QhO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 12:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268087AbUH2QhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 12:37:14 -0400
Received: from gprs214-40.eurotel.cz ([160.218.214.40]:40844 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268085AbUH2QhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 12:37:10 -0400
Date: Sun, 29 Aug 2004 18:36:54 +0200
From: Pavel Machek <pavel@suse.cz>
To: Erik Rigtorp <erik@rigtorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make swsusp produce nicer screen output
Message-ID: <20040829163654.GH3046@elf.ucw.cz>
References: <20040820152317.GA7118@linux.nu> <20040823174217.GC603@openzaurus.ucw.cz> <20040823200858.GA4593@linux.nu> <20040824214929.GA490@openzaurus.ucw.cz> <20040829135403.GA8182@linux.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040829135403.GA8182@linux.nu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Well, it looks nice, be sure to submit smooth version :-).
> > > I'm working on it :).
> > 
> > > > I'd leave dots here. Its usefull to see if it done something or not.
> > > 
> > > Well, it will display a spinning thingy that is updated every time
> > > shrink_all_memory(10000) returns. Maybe you want to see how much memory was
> > > freed?
> > 
> > Yes, it is quite important to see how many pages were freed even after
> > freeing stopped. "done (1234 pages freed)" would solve it...
> Added code for this in the new patch

Okay, wait with that pushing. I merged it here, and did some speedups
(big) in the meantime. Percents for copying memory should no longer be
neccessary.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
