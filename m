Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVLUWjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVLUWjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbVLUWj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 17:39:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:63659 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964848AbVLUWjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 17:39:19 -0500
Date: Wed, 21 Dec 2005 23:38:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2/8] mutex subsystem, add atomic_cmpxchg() to all arches
Message-ID: <20051221223839.GA5163@elte.hu>
References: <20051221155435.GC7243@elte.hu> <200512212255.11286.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512212255.11286.ioe-lkml@rameria.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Oeser <ioe-lkml@rameria.de> wrote:

> On Wednesday 21 December 2005 16:54, Ingo Molnar wrote:
> > add atomic_cmpxchg() to all the architectures. Needed by the new mutex code.
>  
> You add atomic_xchg(), since the above exists already.
> 
> Please fixup your patch description!

thanks, done.

	Ingo
