Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265244AbSJWVjV>; Wed, 23 Oct 2002 17:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265247AbSJWVjV>; Wed, 23 Oct 2002 17:39:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:48799 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265244AbSJWVjT>; Wed, 23 Oct 2002 17:39:19 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 14:54:27 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-aio <linux-aio@kvack.org>
Subject: Re: epoll (was Re: [PATCH] async poll for 2.5)
In-Reply-To: <3DB71720.7070501@netscape.com>
Message-ID: <Pine.LNX.4.44.0210231451330.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, John Gardiner Myers wrote:

>
>
> Davide Libenzi wrote:
>
> >Ok, this pretty much stops every attempt to test/compare AIO with sys_epoll ...
> >
> It would be useful to compare async poll (the patch that started this
> thread) with sys_epoll.  sys_epoll is expected to perform better since
> it ignores multithreading issues and amortizes registration across
> multiple events, but it would be interesting to know by how much.

I think this can be done, David Stevens ( IBM ) already proposed me the
patch to test.



- Davide


