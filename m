Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266157AbSKRX37>; Mon, 18 Nov 2002 18:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266810AbSKRX31>; Mon, 18 Nov 2002 18:29:27 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:34953 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S266157AbSKRX1i>; Mon, 18 Nov 2002 18:27:38 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 18 Nov 2002 15:35:04 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Dan Kegel <dank@kegel.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] epoll interface change and glibc bits ...
In-Reply-To: <3DD97D4D.3010801@kegel.com>
Message-ID: <Pine.LNX.4.44.0211181533501.979-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Nov 2002, Dan Kegel wrote:

> Davide Libenzi wrote:
> > On Mon, 18 Nov 2002, Dan Kegel wrote:
> >
> >>>The interface ( edge-triggered ) is quite different and we saw in the
> >>>previous experience how this might lead to confusion for the user. Putting
> >>>epoll bits inside poll.h will IMHO increase this.
> >>
> >>The only difference is the edge-triggered nature, though, right?
> >
> > Yes, but we have seen that it's enough :)
>
> I'm not so sure.  If the epoll documentation were clear enough
> (which at the moment, frankly, it isn't), I think
> there's a good chance users would not be confused
> by the difference between level-triggered and edge-triggered
> events.
>
> I'd be happy to contribute better doc... has the man page
> for sys_epoll been written yet?

Yep, by a long time :)

http://www.xmailserver.org/linux-patches/epoll.2
http://www.xmailserver.org/linux-patches/epoll_create.2
http://www.xmailserver.org/linux-patches/epoll_ctl.2
http://www.xmailserver.org/linux-patches/epoll_wait.2

it is going to change though with the latest talks about the interface.



- Davide


