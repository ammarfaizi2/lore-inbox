Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWACP6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWACP6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 10:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWACP6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 10:58:53 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60565 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932419AbWACP6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 10:58:52 -0500
Date: Tue, 3 Jan 2006 16:58:43 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Howells <dhowells@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 00/19] mutex subsystem, -V11
Message-ID: <20060103155843.GA10596@elte.hu>
References: <20060103100632.GA23154@elte.hu> <19138.1136303701@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19138.1136303701@warthog.cambridge.redhat.com>
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


* David Howells <dhowells@redhat.com> wrote:

> The attached patch adds a module for testing and benchmarking mutexes, 
> semaphores and R/W semaphores.

thanks!

>  (*) load=N
> 
> 	Each thread delays for N uS whilst holding the lock. The dfault is 0.

could you possibly also add an option that delays a thread while _not_ 
holding the lock? The time spent not holding the lock is an important 
parameter of mutex workloads too.

	Ingo
