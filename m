Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750905AbWAEOBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWAEOBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWAEOBv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:01:51 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:35597 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1750862AbWAEOBu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:01:50 -0500
Date: Mon, 26 Dec 2005 00:33:13 +0000
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, arjan@infradead.org, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, arjanv@infradead.org,
       nico@cam.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de, rmk+lkml@arm.linux.org.uk
Subject: Moore's law (was Re: [patch 0/9] mutex subsystem, -V4)
Message-ID: <20051226003313.GB2440@ucw.cz>
References: <20051222114147.GA18878@elte.hu> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org> <200512251708.16483.zippel@linux-m68k.org> <20051225150445.0eae9dd7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225150445.0eae9dd7.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Another example: Ingo's VFS stresstest which is hitting i_sem hard: it only
> does ~8000 ops/sec on an 8-way, and it's an artificial microbenchmark which
> is _designed_ to hit that lock hard.  So if/when i_sem is converted to a
> mutex, I figure that the benefits to ARM in that workload will be about a
> 0.01% performance increase.  ie: about two hours' worth of Moore's law in a
> dopey microbenchmark.

:-) Expressing performance increases in Moore's hours seems like
neat trick. OTOH I do not think it is valid any more. Single-threaded
performance stopped increasing 2 years ago AFAICS. Plus people are
pushing Linux onto smaller machines, that were unavailable 2 years
ago.


							Pavel
-- 
Thanks, Sharp!
