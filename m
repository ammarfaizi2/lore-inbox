Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270471AbTGWRWp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 13:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270727AbTGWRWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 13:22:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:47367 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S270471AbTGWRWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 13:22:43 -0400
Date: Wed, 23 Jul 2003 13:29:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test1-wli-1 compile fail
In-Reply-To: <20030721213428.GU15452@holomorphy.com>
Message-ID: <Pine.LNX.3.96.1030723132550.20210G-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003, William Lee Irwin III wrote:

> On Mon, Jul 21, 2003 at 05:19:30PM -0400, root wrote:
> > Error:
> > fs/namei.c: In function `path_lookup':
> > fs/namei.c:868: parse error before `*'
> > fs/namei.c:873: `dirs' undeclared (first use in this function)
> > fs/namei.c:873: (Each undeclared identifier is reported only once
> > fs/namei.c:873: for each function it appears in.)
> > fs/namei.c:873: `fs' undeclared (first use in this function)
> > fs/namei.c:890: `task' undeclared (first use in this function)
> > make[1]: *** [fs/namei.o] Error 1
> > make: *** [fs] Error 2
> > gzipped and comment-stripped config attached. And I had such hopes...
> 
> That's moderately unusual. I didn't announce this; it was intended to
> be a drop for various odd testers, not generally released.
> 
> Try 1A, ISTR having compiled that.

Actually it was 1A, I was just looking to see if there was a wli release
there, since the responsiveness has been so good. Far better than mine
taking two days to check the version and get back to you.

Since it's not released, don't worry too much, test1-ac2 has been stable
enough for some testing, and it's not overly slow even on the tiny machine
I'm using for test. I'll try again when/if you release, or you can try
with the config I attached to the original.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

