Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755002AbWKQHGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755002AbWKQHGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 02:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755513AbWKQHGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 02:06:15 -0500
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:37797 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1755002AbWKQHGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 02:06:15 -0500
Date: Fri, 17 Nov 2006 09:06:12 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Yitzchak Eidus <ieidus@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: changing internal kernel system mechanism in runtime by a module patch
Message-ID: <20061117070612.GE3735@rhun.zurich.ibm.com>
References: <e7aeb7c60611161119h3e198e96va07d36d5b2dd6390@mail.gmail.com> <20061117064732.GC3735@rhun.zurich.ibm.com> <20061117065828.GA25155@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117065828.GA25155@infradead.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 06:58:29AM +0000, Christoph Hellwig wrote:

> This kind of stuff is just sick.  Better let them play with their research
> OS for this kind of thing :)

sick, research, what's the difference? :-)

> In practice any non-trivial bug fix requires
> changes to global data structures so reloading a module doesn't make
> sense.

... unless you have a mechanism (which k42 does) to interpose between
data structures and the users of said structures, which you can use to
decide when to repace them.

> And for module-specific problems you should be able to hack around using
> kprobes if you really need (but then again for a mission critical system
> you should have proper active-active failover clustering anyway)

I'm not advocating we merge this - nor have I seen the implementation
for Linux yet - no need to preemptively scorch it from orbit :-)

Cheers,
Muli
