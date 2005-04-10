Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVDJEhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDJEhX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 00:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVDJEhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 00:37:23 -0400
Received: from sccrmhc14.comcast.net ([204.127.202.59]:28926 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261431AbVDJEhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 00:37:16 -0400
Subject: Re: Kernel SCM saga..
From: Albert Cahalan <albert@users.sf.net>
To: torvalds@osdl.org,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 00:20:48 -0400
Message-Id: <1113106849.2325.154.camel@cube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:

> NOTE! I detest the centralized SCM model, but if push comes to shove,
> and we just _can't_ get a reasonable parallell merge thing going in
> the short timeframe (ie month or two), I'll use something like SVN
> on a trusted site with just a few committers, and at least try to
> distribute the merging out over a few people rather than making _me_
> be the throttle.
>
> The reason I don't really want to do that is once we start doing
> it that way, I suspect we'll have a _really_ hard time stopping.
> I think it's a broken model. So I'd much rather try to have some
> pain in the short run and get a better model running, but I just
> wanted to let people know that I'm pragmatic enough that I realize
> that we may not have much choice.

I think you at least instinctively know this, but...

Centralized SCM means you have to grant and revoke commit access,
which means that Linux gets the disease of ugly BSD politics.

Under both the old pre-BitKeeper patch system and under BitKeeper,
developer rank is fuzzy. Everyone knows that some developers are
more central than others, but it isn't fully public and well-defined.
You can change things day by day without having to demote anyone.
While Linux development isn't completely without jealousy and pride,
few have stormed off (mostly IDE developers AFAIK) and none have
forked things as severely as OpenBSD and DragonflyBSD.

You may rank developer X higher than developer Y, but they have
only a guess as to how things are. Perhaps developer X would be
a prideful jerk if he knew. Perhaps developer Y would quit in
resentment if he knew.

Whatever you do, please avoid the BSD-style politics.

(the MAINTAINERS file is bad enough; it has caused problems)


