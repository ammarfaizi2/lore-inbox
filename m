Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSJ2Fb5>; Tue, 29 Oct 2002 00:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261583AbSJ2Fb5>; Tue, 29 Oct 2002 00:31:57 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:64670 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261573AbSJ2Fb4>; Tue, 29 Oct 2002 00:31:56 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 21:47:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <Pine.LNX.4.33L2.0210282121560.13581-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210282144410.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Randy.Dunlap wrote:

> I expect this to be unpopular, but I've been saying lately that
> when new kernel APIs or syscalls or whatsoever are added to
> Linux, there should be sufficient docs along with the patch(es)
> explaining the patch and some intended uses of it, perhaps even
> with examples.  Ingo does this sometimes.  Some people don't
> bother to even come close.
>
> Leading by example would be a nice thing to see here.

Hi Randy, no it's not unpopular :) Those were posted togheter with the
patch :

http://www.xmailserver.org/linux-patches/epoll.txt
http://www.xmailserver.org/linux-patches/epoll_create.txt
http://www.xmailserver.org/linux-patches/epoll_ctl.txt
http://www.xmailserver.org/linux-patches/epoll_wait.txt

to try to explain the new API from user side. From kernel side epoll
completely uses the sk_wake_async() already available by many versions,
and also it is not expected to offer kernel services to other kernel
modules.




- Davide


