Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751552AbWB0GT5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbWB0GT5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 01:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbWB0GT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 01:19:57 -0500
Received: from xenotime.net ([66.160.160.81]:50831 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751083AbWB0GT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 01:19:57 -0500
Date: Sun, 26 Feb 2006 22:21:14 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-rc5
Message-Id: <20060226222114.e549b568.rdunlap@xenotime.net>
In-Reply-To: <4402934B.7040506@pobox.com>
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>
	<4402934B.7040506@pobox.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006 00:51:07 -0500 Jeff Garzik wrote:

> Linus Torvalds wrote:
> > The tar-ball is being uploaded right now, and everything else should 
> > already be pushed out. Mirroring might take a while, of course.
> > 
> > There's not much to say about this: people have been pretty good, and it's 
> > just a random collection of fixes in various random areas. The shortlog is 
> > actually pretty short, and it really describes the updates better than 
> > anything else.
> > 
> > Have I missed anything? Holler. And please keep reminding about any 
> > regressions since 2.6.15.
> 
> Yep, you missed the data corruption fix (libata) and oops fix (netdev) 
> that I sent at 5pm EST today...
> 
> And we may have to turn off FUA (barriers) before 2.6.16 goes out.

Jeff, were you planning to make atapi_enabled=1 be the default
for 2.6.16 ?

---
~Randy
