Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261696AbSJ1Wfv>; Mon, 28 Oct 2002 17:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261701AbSJ1Wfv>; Mon, 28 Oct 2002 17:35:51 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:31637 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261696AbSJ1Wft>; Mon, 28 Oct 2002 17:35:49 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 14:51:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dkegel@ixiacom.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] epoll more scalable than poll
In-Reply-To: <3DBDB33B.6000200@ixiacom.com>
Message-ID: <Pine.LNX.4.44.0210281449150.966-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Dan Kegel wrote:

> Another existing event queue for readiness notification to
> be delivered via is Ben's AIO completion notification queue,
> but I haven't heard a definitive story about whether
> epoll events could be delivered that way.  (The discussion
> seems to always veer into a discussion of asynchronous
> poll, which is something else.)

Yep Dan, Ben proposed that approach that we did not have the time to test.
The way of returning events of sys_epoll is very efficent, like you can
see in the scalability page ( pipetest ) that Hanna and her team setup :

http://lse.sourceforge.net/epoll/index.html



- Davide


