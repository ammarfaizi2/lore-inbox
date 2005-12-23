Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbVLWAA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbVLWAA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbVLWAA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:00:57 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:3979 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751152AbVLWAA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:00:56 -0500
Date: Thu, 22 Dec 2005 19:00:38 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: "Randy.Dunlap" <rdunlap@xenotime.net>
cc: Sean <seanlkml@sympatico.ca>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       arjan@infradead.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
Subject: Re: [patch 0/9] mutex subsystem, -V4
In-Reply-To: <Pine.LNX.4.58.0512221551030.3425@shark.he.net>
Message-ID: <Pine.LNX.4.58.0512221857320.25373@gandalf.stny.rr.com>
References: <20051222114147.GA18878@elte.hu>    <20051222035443.19a4b24e.akpm@osdl.org>
    <20051222122011.GA20789@elte.hu>    <20051222050701.41b308f9.akpm@osdl.org>
    <1135257829.2940.19.camel@laptopd505.fenrus.org>   
 <20051222054413.c1789c43.akpm@osdl.org>    <1135260709.10383.42.camel@localhost.localdomain>
    <20051222153014.22f07e60.akpm@osdl.org>    <20051222233416.GA14182@infradead.org>
 <BAYC1-PASMTP04B55F85E952E6722013B5AE300@CEZ.ICE> <Pine.LNX.4.58.0512221551030.3425@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Dec 2005, Randy.Dunlap wrote:
>
> Andrew can surely answer that, but it could be something as
> simple as wanting to build a more stable kernel (one without
> so much churn), so that things have time to mature and
> improve without breaking so many other things...

Not to mention that when this gets into the kernel, Andrew's the one that
will have to deal with a ton of "switch semaphores to mutexes" patches
that will slowly update the entire kernel.  These patches will probably
continue to come in for a few years. ;)

IIRC, that was one of his rational reasons why he didn't want the timer
name change.

-- Steve

