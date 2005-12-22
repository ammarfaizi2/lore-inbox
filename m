Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbVLVHUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbVLVHUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 02:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965102AbVLVHUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 02:20:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:49368 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965099AbVLVHUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 02:20:41 -0500
Date: Thu, 22 Dec 2005 08:19:40 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jes Sorensen <jes@trained-monkey.org>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@infradead.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 0/8] mutex subsystem, ANNOUNCE
Message-ID: <20051222071940.GA16804@elte.hu>
References: <20051221155411.GA7243@elte.hu> <yq0irtiuxvv.fsf@jaguar.mkp.net> <43AA1134.7090704@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43AA1134.7090704@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> It would be nice to first do a run with a fair implementation of 
> mutexes.

which fairness implementation do you mean - the one where all tasks will 
get the lock in fair FIFO order, and a 'lucky bastard' cannot steal the 
lock from waiters and thus put them at an indefinite disadvantage?

	Ingo
