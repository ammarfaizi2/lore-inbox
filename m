Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265240AbSJWVgO>; Wed, 23 Oct 2002 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265241AbSJWVgO>; Wed, 23 Oct 2002 17:36:14 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:57246 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S265240AbSJWVgN>; Wed, 23 Oct 2002 17:36:13 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 23 Oct 2002 14:51:21 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: John Gardiner Myers <jgmyers@netscape.com>
cc: linux-aio <linux-aio@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: async poll
In-Reply-To: <3DB7136E.8090205@netscape.com>
Message-ID: <Pine.LNX.4.44.0210231442490.1581-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002, John Gardiner Myers wrote:

> > In that situation, why not just add the fd to an epoll, and have the
> > epoll deliver events through Ben's interface?
>
> Because you might need to use the aio_data facility of the iocb
> interface.  Because you might want to keep the kernel from
> simultaneously delivering two events for the same fd to two different
> threads.

Why would you want to have a single fd simultaneously handled by two
different threads with all the locking issues that would arise ? I can
understand loving threads but this seems to be too much :)



- Davide



