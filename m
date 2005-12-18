Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965233AbVLRRZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965233AbVLRRZb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 12:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965234AbVLRRZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 12:25:31 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:63659 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965233AbVLRRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 12:25:30 -0500
Date: Sun, 18 Dec 2005 12:25:18 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Daniel Walker <dwalker@mvista.com>,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [PATCH rc5-rt2 0/3] plist: alternative implementation
In-Reply-To: <Pine.LNX.4.58.0512181220420.21304@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0512181224390.21304@gandalf.stny.rr.com>
References: <43A5A7B5.21A4CAAE@tv-sign.ru> <Pine.LNX.4.58.0512181220420.21304@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 18 Dec 2005, Steven Rostedt wrote:

>
> On Sun, 18 Dec 2005, Oleg Nesterov wrote:
>
> > Rediff against patch-2.6.15-rc5-rt2.
> >
> > Nothing was changed except s/plist_next_entry/plist_first_entry/
> > to match the current naming.
> >
> > These patches were only compile tested. This is beacuse I can't
> > even compile 2.6.15-rc5-rt2, I had to comment out this line
> >
> > 	lib-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += rwsem.o
> >
> > in lib/Makefile. I think CONFIG_RWSEM_GENERIC_SPINLOCK means that
> > lib/rwsem.c should be ignored.
> >
>
> I've already submitted patches to Ingo to fix this.
>

Oh, and here's the link to that post.

http://marc.theaimsgroup.com/?l=linux-kernel&m=113448476303030&w=2

-- Steve

