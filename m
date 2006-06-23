Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751833AbWFWSFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWFWSFe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751835AbWFWSFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:05:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:11176 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751833AbWFWSFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:05:33 -0400
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>
In-Reply-To: <Pine.LNX.4.64.0606231042350.6483@g5.osdl.org>
References: <20060619175243.24655.76005.sendpatchset@lappy>
	 <20060619175253.24655.96323.sendpatchset@lappy>
	 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
	 <1151019590.15744.144.camel@lappy>
	 <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
	 <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0606231042350.6483@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 20:05:24 +0200
Message-Id: <1151085924.3204.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My main worry has always been the effects of this on some strange load, 
> not the stability itself.
> 
> > And have we even seen stats for it yet?  We know that it shouldn't
> > affect the vast majority of loads (not mapping shared writable), but
> > it won't be fixing any problem on them either; and we've had reports
> > that it does fix the issue, but at what perf cost? (I may have missed)
> 
> _Exactly_. This is why I think earlier rather than later is better. 
> 
> Sitting in -mm won't get us any new unexpected load cases - only more of 
> the same that hasn't shown any huge flags per se (although the dirty limit 
> discussion clearly shows people are at least thinking about it).


one options it to ask the distributions to put this into their more
experimental kernels for a bit to give it a broader exposure... it's
still a bit small but at least broader than "kernel developers"...

