Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261390AbVBOAPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261390AbVBOAPr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbVBOAPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:15:47 -0500
Received: from gprs215-140.eurotel.cz ([160.218.215.140]:41932 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261390AbVBOAPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:15:35 -0500
Date: Tue, 15 Feb 2005 01:15:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, Bernard Blackham <bernard@blackham.com.au>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-ID: <20050215001514.GB2116@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au> <20050214213400.GF12235@elf.ucw.cz> <20050214134658.324076c9.akpm@osdl.org> <1108418226.12611.75.camel@desktop.cunningham.myip.net.au> <20050214220459.GM12235@elf.ucw.cz> <1108418990.12611.86.camel@desktop.cunningham.myip.net.au> <20050214234151.GA2134@elf.ucw.cz> <1108426556.3666.1.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108426556.3666.1.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I guess I'm wrong then - I thought the other changes avoided compilation
> > > errors.
> > 
> > Well, yes, if you switch pm_message_t into struct. But we are not yet
> > ready to do that... it is going to be typedefed to u32 for 2.6.11...
> 
> Ah. So I haven't realised that Bernard took your patches wholesale,
> which is why we're fixing the compile errors too :>
> 
> Okay then, I guess the whole thing isn't urgent then?

Well, it would be nice to be able to switch to struct pm_message_t
very soon in 2.6.12 cycle, so that it actually works in 2.6.12...

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
