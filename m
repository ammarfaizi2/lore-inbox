Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbVLWO6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbVLWO6E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 09:58:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030525AbVLWO6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 09:58:04 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:23052 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030507AbVLWO6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 09:58:01 -0500
Date: Fri, 23 Dec 2005 14:57:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Nicolas Pitre <nico@cam.org>, hch@infradead.org, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, jes@trained-monkey.org,
       zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
       bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de
Subject: Re: [patch 0/9] mutex subsystem, -V4
Message-ID: <20051223145746.GA2077@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Nicolas Pitre <nico@cam.org>, hch@infradead.org,
	alan@lxorguk.ukuu.org.uk, arjan@infradead.org, mingo@elte.hu,
	linux-kernel@vger.kernel.org, torvalds@osdl.org,
	arjanv@infradead.org, jes@trained-monkey.org,
	zwane@arm.linux.org.uk, oleg@tv-sign.ru, dhowells@redhat.com,
	bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de
References: <20051222122011.GA20789@elte.hu> <20051222050701.41b308f9.akpm@osdl.org> <1135257829.2940.19.camel@laptopd505.fenrus.org> <20051222054413.c1789c43.akpm@osdl.org> <1135260709.10383.42.camel@localhost.localdomain> <20051222153014.22f07e60.akpm@osdl.org> <20051222233416.GA14182@infradead.org> <20051222221311.2f6056ec.akpm@osdl.org> <Pine.LNX.4.64.0512230912220.26663@localhost.localdomain> <20051223065118.95738acc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223065118.95738acc.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 06:51:18AM -0800, Andrew Morton wrote:
> Nicolas Pitre <nico@cam.org> wrote:
> > How can't you get the fact that semaphores could _never_ be as simple as 
> > mutexes?  This is a theoritical impossibility, which maybe turns out not 
> > to be so true on x86, but which is damn true on ARM where the fast path 
> > (the common case of a mutex) is significantly more efficient.
> 
> I did notice your comments.  I'll grant that mutexes will save some tens of
> fastpath cycles on one minor architecture.  Sorry, but that doesn't seem
> very important.

Wow.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
