Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263046AbTHVGNY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 02:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263048AbTHVGNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 02:13:24 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:59811 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S263046AbTHVGNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 02:13:22 -0400
From: David Lang <david.lang@digitalinsight.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>, Lou Langholtz <ldl@aros.net>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Date: Thu, 21 Aug 2003 23:10:48 -0700 (PDT)
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
In-Reply-To: <Pine.LNX.4.44.0308211254360.1606-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0308212308350.2232-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Aug 2003, Linus Torvalds wrote:

> On Thu, 21 Aug 2003, Matthew Wilcox wrote:
> >
> > But why is it interesting to have this information at boot time?  As a
> > user, I certainly don't care.  As a developer, I don't find it interesting
> > information.
>
> I do agree. The message may have been useful when the code was young and
> people wanted to see that it got executed correctly at all, but there
> doesn't seem to be a lot of point to it any more.
>
> But hey, I'll leave it to the maintainer..
>
> 		Linus

as a user I find a minimal set of messages (loading driver, hardware
found) handy for identifying what hardware is actually in old machines I
am given.

that said there is a lot of distance between that and the current
situation where you print out 3-4 screens worth of info for a single
driver.

David Lang
