Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUB1V3N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 16:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUB1V3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 16:29:13 -0500
Received: from mail.tmr.com ([216.238.38.203]:44040 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261924AbUB1V3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 16:29:08 -0500
Date: Sat, 28 Feb 2004 16:27:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Rik van Riel <riel@surriel.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
In-Reply-To: <Pine.LNX.4.55L.0402262244130.17359@imladris.surriel.com>
Message-ID: <Pine.LNX.3.96.1040228161308.8661A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Rik van Riel wrote:

> On Thu, 26 Feb 2004, Bill Davidsen wrote:
> 
> > I disagree.
> 
> > It would be nice to have the scheduler identify processes which
> > interface to user information devices, but it must be done in a way
> > which doesn't open gaping security or misuse holes.
> 
> You seem to disagree only with what you think you read,
> not with what the code does.  Please read the actual
> code, since it seems to do what you propose.

I disagree with the paragraph preceding my comment, which you removed to
take what I said out of context. And I still disagree. I "think I read" 
that just fine, although it may not correctly summarize the implementation
of the code.

In any case, as long as the code provides the protection against letting
users change priorities to hog resources I don't disagree with that.
Experience has shown that people WILL abuse any mechanism which gives them
an unfair share of a shared system. For home systems that's less
important, obviously.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

