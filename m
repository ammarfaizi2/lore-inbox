Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSKBWAX>; Sat, 2 Nov 2002 17:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSKBWAX>; Sat, 2 Nov 2002 17:00:23 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34436 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261440AbSKBWAV>; Sat, 2 Nov 2002 17:00:21 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sat, 2 Nov 2002 14:11:44 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: bert hubert <ahu@ds9a.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] total-epoll r2 ...
In-Reply-To: <20021102213759.GA9440@outpost.ds9a.nl>
Message-ID: <Pine.LNX.4.44.0211021409570.951-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Nov 2002, bert hubert wrote:

> On Sat, Nov 02, 2002 at 11:40:55AM -0800, Davide Libenzi wrote:
>
> > http://www.xmailserver.org/linux-patches/epoll.txt
>
> This page still contains:
>
>        Furthermore, the function do_use_fd() immediately tries to read(2)
>        from the fd. If it does not do so, there is a race condition with the
>        risk of losing an event before interest in it was registered.  This
>        read may well return EAGAIN, which should be a cause for calling
>        epoll_wait().
>
> Am I correct in understanding that this is no longer true because epoll_ctl
> inserts an event if the poll condition is met?

Yep, I forgot to edit that one ...



> Furthermore, I don't think the epoll(2) page is that helpful as even an
> application developer that follows lkml (ie, me) has any use of the
> 'waitqueue' analogy.

Sigh, I liked Jamie explanation :)
Ok, there's still some work to do on man pages ...



- Davide


