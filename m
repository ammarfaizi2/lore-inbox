Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbSJaUxp>; Thu, 31 Oct 2002 15:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263178AbSJaUxp>; Thu, 31 Oct 2002 15:53:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:15375 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id <S263137AbSJaUxl>;
	Thu, 31 Oct 2002 15:53:41 -0500
Message-ID: <3DC199B5.8DDE2FE1@redhat.com>
Date: Thu, 31 Oct 2002 15:59:34 -0500
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.3.genterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0210311015380.1410-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Oct 2002, Linus Torvalds wrote:

>  - included features kill off (potentially better) projects.
>
>         There's a big "inertia" to features. It's often better to keep
>         features _off_ the standard kernel if they may end up being
>         further developed in totally new directions.
>
>         In particular when it comes to this project, I'm told about
>         "netdump", which doesn't try to dump to a disk, but over the net.
>         And quite frankly, my immediate reaction is to say "Hell, I
>         _never_ want the dump touching my disk, but over the network
>         sounds like a great idea".
>
> To me this says "LKCD is stupid". Which means that I'm not going to apply
> it, and I'm going to need some real reason to do so - ie being proven
> wrong in the field.
>
> (And don't get me wrong - I don't mind getting proven wrong. I change my
> opinions the way some people change underwear. And I think that's ok).

It would be most unfortunate if the existance of netdump is used as a
reason to deny LKCD's inclusion, or to simply dismiss LKCD as stupid.

On Thu, 31 Oct 2002, Matt D. Robinson wrote:

> We want to see this in the kernel, frankly, because it's a pain
> in the butt keeping up with your kernel revisions and everything
> else that goes in that changes.  And I'm sure SuSE, UnitedLinux and
> (hopefully) Red Hat don't want to spend their time having to roll
> this stuff in each and every time you roll a new kernel.

While Red Hat advocates Ingo's netdump option, we have customer
requests that are requiring us to look at LKCD disk-based dumps as an
alternative, co-existing dump mechanism.  Since the two methods are not mutually
exclusive, LKCD will never kill off netdump -- nor certainly vice-versa.  We're
all just looking for a better means to be able to
provide support to our customers, not to mention its value as a
development aid.

Dave Anderson
Red Hat, Inc.



