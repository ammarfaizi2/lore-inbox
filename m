Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSJ2FiU>; Tue, 29 Oct 2002 00:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261590AbSJ2FiU>; Tue, 29 Oct 2002 00:38:20 -0500
Received: from air-2.osdl.org ([65.172.181.6]:7568 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261583AbSJ2FiT>;
	Tue, 29 Oct 2002 00:38:19 -0500
Date: Mon, 28 Oct 2002 21:41:13 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <Pine.LNX.4.44.0210282144410.1002-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L2.0210282137280.13581-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Davide Libenzi wrote:

| On Mon, 28 Oct 2002, Randy.Dunlap wrote:
|
| > I expect this to be unpopular, but I've been saying lately that
| > when new kernel APIs or syscalls or whatsoever are added to
| > Linux, there should be sufficient docs along with the patch(es)
| > explaining the patch and some intended uses of it, perhaps even
| > with examples.  Ingo does this sometimes.  Some people don't
| > bother to even come close.
| >
| > Leading by example would be a nice thing to see here.
|
| Hi Randy, no it's not unpopular :) Those were posted togheter with the
| patch :
|
| http://www.xmailserver.org/linux-patches/epoll.txt
| http://www.xmailserver.org/linux-patches/epoll_create.txt
| http://www.xmailserver.org/linux-patches/epoll_ctl.txt
| http://www.xmailserver.org/linux-patches/epoll_wait.txt
|
| to try to explain the new API from user side. From kernel side epoll
| completely uses the sk_wake_async() already available by many versions,
| and also it is not expected to offer kernel services to other kernel
| modules.

Yes, I knew that and I thought about it while typing, but
my dynamic RAM was too dynamic and not being refreshed often
enough.  Thanks for doing it for me.

BTW, I didn't mean unpopular for the epoll patch, I meant
unpopular in general, especially for development kernel patches:
if every new feature required docs along with it, it might slow
down Linux development by one day, but help out everyone in
the long run (tm?).

-- 
~Randy

