Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261597AbSJ2GAM>; Tue, 29 Oct 2002 01:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261598AbSJ2GAM>; Tue, 29 Oct 2002 01:00:12 -0500
Received: from air-2.osdl.org ([65.172.181.6]:21401 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261597AbSJ2GAK>;
	Tue, 29 Oct 2002 01:00:10 -0500
Date: Mon, 28 Oct 2002 22:03:00 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <Pine.LNX.4.44.0210282203100.1002-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33L2.0210282200360.13622-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Davide Libenzi wrote:

| On Mon, 28 Oct 2002, Randy.Dunlap wrote:
|
| > Yes, I knew that and I thought about it while typing, but
| > my dynamic RAM was too dynamic and not being refreshed often
| > enough.  Thanks for doing it for me.
|
| I knew it, I already sent you the links before :)
Yep.  8:)

| > BTW, I didn't mean unpopular for the epoll patch, I meant
| > unpopular in general, especially for development kernel patches:
| > if every new feature required docs along with it, it might slow
| > down Linux development by one day, but help out everyone in
| > the long run (tm?).
|
| I do agree Randy about comments, don't get me wrong. But you know what my
| job condition is :) Looking at the kernel source though, you find
| something like :
|
| 	/* add the fd to the interest set */
| 	do_add_fd_to_the_interest_set();
|
| and then you have the code that really would need comments completely
| naked. While, again, I do agree that comments are completely missing in
| the patch, I'm not that kind of guy that would like a function like :
|
| static struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
| {
...
| }
|
| commented with "search an fd inside the hash". What a comment like that
| adds to this code ?

nada.

Just to be clear (and reiterate), my comments were not about
the epoll patch, but about adding new features/kernel APIs/etc
in general.

Later,
-- 
~Randy

