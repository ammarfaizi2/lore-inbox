Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWJEXfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWJEXfh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 19:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWJEXfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 19:35:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751474AbWJEXff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 19:35:35 -0400
Date: Thu, 5 Oct 2006 16:35:02 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers 
In-Reply-To: <18975.1160058127@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0610051632250.3952@g5.osdl.org>
References: <20061002132116.2663d7a3.akpm@osdl.org> 
 <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> 
 <18975.1160058127@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 5 Oct 2006, David Howells wrote:
> 
> Anyway, I've made a GIT tree with just IRQ my patches in.  It can be browsed
> at:
> 
> 	http://git.infradead.org/?p=users/dhowells/irq-2.6.git;a=shortlog
> 
> Or pulled from:
> 
> 	git://git.infradead.org/~dhowells/irq-2.6.git

Gaah. It has those ugly "cherry-picked from" messages (please use "-r" 
when cherry-picking, or "-e" and edit them out), but it looks fine 
otherwise, and I think I heard a _very_ convincing "please do it" from 
everybody involved when this was discussed, so I've pulled. 

Any fall-out from this should be both obvious and pretty trivial to fix 
up.

		Linus
