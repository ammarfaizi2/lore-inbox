Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUEKCrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUEKCrN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 22:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUEKCrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 22:47:13 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:38321 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261786AbUEKCrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 22:47:10 -0400
Date: Mon, 10 May 2004 19:47:01 -0700
From: Chris Wedgwood <cw@f00f.org>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: nautilus-list@gnome.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040511024701.GA19489@taniwha.stupidest.org>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084227460.28663.8.camel@vertex>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 06:17:40PM -0400, John McCutchan wrote:

> According to everyone who uses dnotify it is.

I don't buy that.  I have used dnotify and signals where not an issue.
Why is this an issue for others?

> > 3) dnotify cannot easily watch changes for a directory hierarchy

> People don't seem to really care about this one. Alexander Larsson
> has said he doesn't care about it. It might be nice to add in the
> future.

I don't know who that is and why it matters.

Without being able to watch a hierarchy, I'm not sure inotify buys
anything that we can't get from dnotify right now though.  It's also
more complex.

> The idea is to encourage use of a user-space daemon that will
> multiplex all requests, so if 5 people want to watch /somedir the
> daemon will only use one watcher in the kernel. The number might be
> too low, but its easily upped.

If you are to use a daemon for this, why no use dnotify?



   --cw
