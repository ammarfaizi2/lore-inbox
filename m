Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVHLRBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVHLRBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbVHLRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:01:16 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:41131 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750726AbVHLRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:01:15 -0400
Date: Fri, 12 Aug 2005 13:01:05 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
Reply-To: rostedt@goodmis.org
To: Linus Torvalds <torvalds@osdl.org>
cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Fix mmap_kmem (was: [question] What's the difference
 between /dev/kmem and /dev/mem)
In-Reply-To: <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
Message-ID: <Pine.LNX.4.58.0508121253390.26361@localhost.localdomain>
References: <1123796188.17269.127.camel@localhost.localdomain>
 <1123809302.17269.139.camel@localhost.localdomain> <Pine.LNX.4.58.0508120930150.3295@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 12 Aug 2005, Linus Torvalds wrote:
>
> I'm actually more inclined to try to deprecate /dev/kmem.. I don't think
> anybody has ever really used it except for some rootkits. It only exists
> in the first place because it's historical.
>
> We do need to support /dev/mem for X, but even that might go away some
> day.
>
> So I'd be perfectly happy to fix this, but I'd be even happier if we made
> the whole kmem thing a config variable (maybe even default it to "off").
>

I don't mind it as a config option, but please don't deprecate it.  I
use it a lot (actually I've been using /dev/mem until now, that kmem seems
better) for debug tools that I write.  That is, user land programs to
monitor various parts of the kernel.

Thanks,

-- Steve

