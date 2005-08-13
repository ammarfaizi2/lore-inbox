Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVHMQ4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVHMQ4o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVHMQ4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:56:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58045 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932208AbVHMQ4o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:56:44 -0400
Date: Sat, 13 Aug 2005 09:56:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <1123951810.3187.20.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.58.0508130955010.19049@g5.osdl.org>
References: <1123796188.17269.127.camel@localhost.localdomain> 
 <1123809302.17269.139.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org> <1123951810.3187.20.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Aug 2005, Arjan van de Ven wrote:
> > 
> > So I'd be perfectly happy to fix this, but I'd be even happier if we made 
> > the whole kmem thing a config variable (maybe even default it to "off").
> 
> attached is a simple patch that does exactly this...

Well, you should have fixed the bug that Steven had at the same time. Now 
his patch won't even apply any more, I suspect ;)

		Linus
