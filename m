Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267547AbSKQSg1>; Sun, 17 Nov 2002 13:36:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267549AbSKQSg1>; Sun, 17 Nov 2002 13:36:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:38275 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S267547AbSKQSg0>; Sun, 17 Nov 2002 13:36:26 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Nov 2002 10:43:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mark Hamblin <MarkHamblin@cox.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] epoll bits 0.46 ...
In-Reply-To: <013601c28e3e$5ed0bd50$0200a8c0@cirilium.com>
Message-ID: <Pine.LNX.4.44.0211171042170.7295-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Nov 2002, Mark Hamblin wrote:

> Hi,
>
> I have kind of a newbie question.  I have a compiled version of 2.5.47 and I
> can boot it up to runlevel 3 with the loopback network interface (i.e.,
> 127.0.0.1) working.  In this configuration I can use the old select () and
> poll () system calls, so I think I should be able to at least try out
> sys_epoll_....
>
> I tried including /usr/src/linux-2.5.47/include/linux/eventpoll.h, but that
> doesn't get me the declarations I need for my testing.
>
> I looked for epoll.h, as referenced in the examples on your web page, but it
> is not part of your patch.
>
> So then I just put in a dummy "extern int epoll_create (int);", which got me
> through the compiling stage, but it still failed to link.  Is there some
> simple step(s) I can take (to update what libraries I'm linking?) so I can
> try to play around with this in user space?

Hi Mark,

you need the user space library ( epoll_lib ) :

http://www.xmailserver.org/linux-patches/nio-improve.html#sys_epoll



- Davide


