Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261584AbSJ2FZa>; Tue, 29 Oct 2002 00:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJ2FZa>; Tue, 29 Oct 2002 00:25:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:64395 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261584AbSJ2FZ1>;
	Tue, 29 Oct 2002 00:25:27 -0500
Date: Mon, 28 Oct 2002 21:28:12 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Andrew Morton <akpm@digeo.com>
cc: Hanna Linder <hannal@us.ibm.com>, <torvalds@transmeta.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lse-tech@lists.sourceforge.net>, <ahu@ds9a.nl>
Subject: Re: [Lse-tech] Re: [PATCH] Updated sys_epoll now with man pages
In-Reply-To: <3DBE1824.B3D84E9F@digeo.com>
Message-ID: <Pine.LNX.4.33L2.0210282121560.13581-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Oct 2002, Andrew Morton wrote:

| Hanna Linder wrote:
| >
| >    sys_epoll-2.5.44-last.diff
|
| Folks,
|
| when I took a 15-minute look at this code last week I found several
| bugs, some of which were grave.  It's a terrible thing to say, but
| a sensible person would expect that a closer inspection would turn
| up more problems.
|
| Now, adding bugs to existing code is fine and traditional - people
| find them quickly and they get fixed up.
|
| But for *new* code, problems will take months to discover.  The only
| practical way to get this code vetted for inclusion is a close review.
|
| And that is a sizeable task.  The core implementation file is
| 1,600 lines.  And I wonder how many people have counted the
| number of comments in there?
|
| Well, I'll make it easy: zero.  Nil.  Nada.
|
| (Well, OK, a copyright header, and something which got cut-n-pasted
| from inode.c)
|
| In my wildly unconventional opinion this alone makes epoll just a hack,
| of insufficient quality for inclusion in Linux.  We *have* to stop doing
| this to ourselves!

I expect this to be unpopular, but I've been saying lately that
when new kernel APIs or syscalls or whatsoever are added to
Linux, there should be sufficient docs along with the patch(es)
explaining the patch and some intended uses of it, perhaps even
with examples.  Ingo does this sometimes.  Some people don't
bother to even come close.

Leading by example would be a nice thing to see here.

And "use the source Luke" is cool and is definitive.
But it's not the only way to get things done.
Well, maybe it is, but it shouldn't and needn't be.

| epoll seems to be a good and desirable thing.  To move forward I
| believe we need to get this code reviewed, and documented.
|
| I can do that if you like; it will take me several weeks to get onto
| it.  But until that is completed I would oppose inclusion of this
| code.
| -------------------------------------------------------

-- 
~Randy

