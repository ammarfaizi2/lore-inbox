Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSGVNgz>; Mon, 22 Jul 2002 09:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGVNgz>; Mon, 22 Jul 2002 09:36:55 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48026 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S315536AbSGVNgy>;
	Mon, 22 Jul 2002 09:36:54 -0400
Date: Mon, 22 Jul 2002 15:38:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Christoph Hellwig <hch@lst.de>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Robert Love <rml@tech9.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
In-Reply-To: <20020722152645.A18695@lst.de>
Message-ID: <Pine.LNX.4.44.0207221537450.8903-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 22 Jul 2002, Christoph Hellwig wrote:

> > i agree mostly, but i do not agree with __irq_save() and irq_save().  
> > What's wrong with "flags_t irq_save_off()" - the name carries the proper
> > meaning, and it also harmonizes with irq_off().
> 
> but not with irq_restore :)  maybe irq_restore_on() although the on is
> implicit.

think about it - if this was true then irq_restore_on() would be
equivalent to irq_on().

	Ingo

