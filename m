Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261826AbTCLSQs>; Wed, 12 Mar 2003 13:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261832AbTCLSQs>; Wed, 12 Mar 2003 13:16:48 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:60843 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261826AbTCLSQr>; Wed, 12 Mar 2003 13:16:47 -0500
X-AuthUser: davidel@xmailserver.org
Date: Wed, 12 Mar 2003 10:36:43 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Martin Waitz <tali@admingilde.org>
cc: Niels Provos <provos@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marius Aamodt Eriksen <marius@citi.umich.edu>
Subject: Re: [patch, rfc] lt-epoll ( level triggered epoll ) ...
In-Reply-To: <20030312180550.GA27366@admingilde.org>
Message-ID: <Pine.LNX.4.50.0303121031400.991-100000@blue1.dev.mcafeelabs.com>
References: <Pine.LNX.4.50.0303101139520.1922-100000@blue1.dev.mcafeelabs.com>
 <20030311043202.GK2225@citi.citi.umich.edu> <20030312180550.GA27366@admingilde.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Mar 2003, Martin Waitz wrote:

> On Mon, Mar 10, 2003 at 11:32:02PM -0500, Niels Provos wrote:
> > It seems that option 3) which implements both "edge" and "level"
> > triggered behavior is the best solution.  This is similar to kqueue
> > which supports both triggering modes.
> imho the kqueue api is a lot nicer anyway.
>
> what about simply implementing kqueue?
> it's already available in other OS's,
> so it's easier for application developers to adopt it, too.

See opinions about APIs are strictly personal. IMO kqueue is overbloated
for example. The epoll API is extremely easy to use and very much remember
the poll one, that many developers are used to. If you want to make your
software completely abstract, you can use Niels's libevent library for
example, that supports poll/select/epoll/kqueue.



- Davide

