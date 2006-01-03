Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932443AbWACQt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbWACQt3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 11:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWACQtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 11:49:25 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:4520 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932446AbWACQtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 11:49:15 -0500
Date: Tue, 3 Jan 2006 17:49:01 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 08/19] mutex subsystem, core
Message-ID: <20060103164901.GA26773@elte.hu>
References: <20060103100807.GH23289@elte.hu> <43BABBB8.402E96A3@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43BABBB8.402E96A3@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.0 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> > mutex implementation, core files: just the basic subsystem, no users of it.
> 
> (on top of this patch)
> 
> 'add_to_head' always declared and used along with 'struct waiter'. I 
> think it is better to hide 'add_to_head' in that struct.

please check -V13, there i got rid of add_to_head altogether, by 
changing the queueing logic.

	Ingo
