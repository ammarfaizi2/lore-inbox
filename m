Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbSJ2FPl>; Tue, 29 Oct 2002 00:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSJ2FPl>; Tue, 29 Oct 2002 00:15:41 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:58526 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S261567AbSJ2FPk>; Tue, 29 Oct 2002 00:15:40 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 28 Oct 2002 21:31:28 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <3DBE1824.B3D84E9F@digeo.com>
Message-ID: <Pine.LNX.4.44.0210282126470.1002-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andrew Morton wrote:

> Folks,
>
> when I took a 15-minute look at this code last week I found several
> bugs, some of which were grave.  It's a terrible thing to say, but
> a sensible person would expect that a closer inspection would turn
> up more problems.
>
> Now, adding bugs to existing code is fine and traditional - people
> find them quickly and they get fixed up.
>
> But for *new* code, problems will take months to discover.  The only
> practical way to get this code vetted for inclusion is a close review.
>
> And that is a sizeable task.  The core implementation file is
> 1,600 lines.  And I wonder how many people have counted the
> number of comments in there?
>
> Well, I'll make it easy: zero.  Nil.  Nada.
>
> (Well, OK, a copyright header, and something which got cut-n-pasted
> from inode.c)
>
> In my wildly unconventional opinion this alone makes epoll just a hack,
> of insufficient quality for inclusion in Linux.  We *have* to stop doing
> this to ourselves!
>
>
> epoll seems to be a good and desirable thing.  To move forward I
> believe we need to get this code reviewed, and documented.
>
> I can do that if you like; it will take me several weeks to get onto
> it.  But until that is completed I would oppose inclusion of this
> code.

Andrew, last time you wrote me you told me that it was a matter of a
couple of hour to spend togheter to look at the code. And believe that a
couple of hours are the just about the right time. Most of the code is
_trivial_ and the "core code" can be condensed in no more than 100 lines.
I agree with you that comment are missing, but I don't think it's a
problem to add them in the "sensible" places. It'd would ahve helped if
you would have given me this feedback one week ago though ...



- Davide


