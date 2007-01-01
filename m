Return-Path: <linux-kernel-owner+w=401wt.eu-S932312AbXAAXWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbXAAXWT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 18:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbXAAXWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 18:22:19 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4405 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754724AbXAAXWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 18:22:18 -0500
Date: Mon, 1 Jan 2007 17:28:03 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: Ollie Wild <aaw@google.com>, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] remove MAX_ARG_PAGES
Message-ID: <20070101172803.GC4214@ucw.cz>
References: <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com> <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com> <20061229200357.GA5940@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229200357.GA5940@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> FYI, i have forward ported your MAX_ARG_PAGES limit removal patch to 
> 2.6.20-rc2 and have included it in the -rt kernel. It's working great - 
> i can now finally do a "ls -t patches/*.patch" in my patch repository - 
> something i havent been able to do for years ;-)
> 
> what is keeping this fix from going upstream?

+1

I like this. I've been running with MAX_ARG_PAGES raised to insane
value, and I'd love to get rid of that hack.

							Pavel
-- 
Thanks for all the (sleeping) penguins.
