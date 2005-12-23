Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030554AbVLWPFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030554AbVLWPFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Dec 2005 10:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbVLWPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Dec 2005 10:05:16 -0500
Received: from smtp11.wanadoo.fr ([193.252.22.31]:8214 "EHLO smtp11.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1030554AbVLWPFO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Dec 2005 10:05:14 -0500
X-ME-UUID: 20051223150512942.E61741C000B1@mwinf1103.wanadoo.fr
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Xavier Bestel <xavier.bestel@free.fr>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Nicolas Pitre <nico@cam.org>,
       hch@infradead.org, alan@lxorguk.ukuu.org.uk, arjan@infradead.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       arjanv@infradead.org, jes@trained-monkey.org, zwane@arm.linux.org.uk,
       oleg@tv-sign.ru, dhowells@redhat.com, bcrl@kvack.org,
       rostedt@goodmis.org, ak@suse.de
In-Reply-To: <20051223145746.GA2077@flint.arm.linux.org.uk>
References: <20051222122011.GA20789@elte.hu>
	 <20051222050701.41b308f9.akpm@osdl.org>
	 <1135257829.2940.19.camel@laptopd505.fenrus.org>
	 <20051222054413.c1789c43.akpm@osdl.org>
	 <1135260709.10383.42.camel@localhost.localdomain>
	 <20051222153014.22f07e60.akpm@osdl.org>
	 <20051222233416.GA14182@infradead.org>
	 <20051222221311.2f6056ec.akpm@osdl.org>
	 <Pine.LNX.4.64.0512230912220.26663@localhost.localdomain>
	 <20051223065118.95738acc.akpm@osdl.org>
	 <20051223145746.GA2077@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1135350288.6493.258.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 23 Dec 2005 16:04:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-23 at 15:57, Russell King wrote:
> On Fri, Dec 23, 2005 at 06:51:18AM -0800, Andrew Morton wrote:
> > Nicolas Pitre <nico@cam.org> wrote:
> > > How can't you get the fact that semaphores could _never_ be as simple as 
> > > mutexes?  This is a theoritical impossibility, which maybe turns out not 
> > > to be so true on x86, but which is damn true on ARM where the fast path 
> > > (the common case of a mutex) is significantly more efficient.
> > 
> > I did notice your comments.  I'll grant that mutexes will save some tens of
> > fastpath cycles on one minor architecture.  Sorry, but that doesn't seem
> > very important.
> 
> Wow.

Yes, wow. Andrew doesn't seem aware of embedded linux people, for whom
cycles are important and ARM is king.

	Xav


