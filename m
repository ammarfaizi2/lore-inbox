Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261532AbVBNVeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261532AbVBNVeQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 16:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVBNVeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 16:34:16 -0500
Received: from gprs214-75.eurotel.cz ([160.218.214.75]:38881 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261532AbVBNVeM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 16:34:12 -0500
Date: Mon, 14 Feb 2005 22:34:00 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Bernard Blackham <bernard@blackham.com.au>, Andrew Morton <akpm@digeo.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Address lots of pending pm_message_t changes
Message-ID: <20050214213400.GF12235@elf.ucw.cz>
References: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1108359808.12611.37.camel@desktop.cunningham.myip.net.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is a conglomeration of about 5 patches that complete (I
> think!) the work of switching over to pm_message_t. Most of this work
> was done by Bernard Blackham, some by me, some by Pavel I think (I was
> out of action for part of the development). I believe it needs to go in
> before 2.6.11 in order to avoid compilation warnings and errors. The
> code has been in use by Suspend2 users for around three weeks. Please
> apply.
> 
> Pavel and Bernard, can you review and give your signoff?

Changes that change no code (u32 -> pm_message_t) are okay with me;
anything changing code (.event) has to wait after 2.6.11.

Andrew, if you get one big patch doing only type-safety (u32 ->
pm_message_t, no code changes), would you still take it this late? I
promise it is not going to break anything... It would help merge after
2.6.11 quite a lot...
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
