Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284304AbRLBTvb>; Sun, 2 Dec 2001 14:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284303AbRLBTvW>; Sun, 2 Dec 2001 14:51:22 -0500
Received: from xdsl-213-168-117-70.netcologne.de ([213.168.117.70]:912 "EHLO
	ecce.homeip.net") by vger.kernel.org with ESMTP id <S284310AbRLBTvL>;
	Sun, 2 Dec 2001 14:51:11 -0500
Date: Sun, 2 Dec 2001 19:50:28 +0000 (UTC)
From: Thorsten Glaser <mirabilos@users.sourceforge.net>
To: Davide Libenzi <davidel@xmailserver.org>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_struct colouring ...
In-Reply-To: <Pine.LNX.4.40.0112021148540.7375-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.BSO.4.42.0112021949170.32167-100000@ecce.homeip.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dixitur de Davide Libenzi respondebo ad:
> > > > > movl %esp, %eax
> > > > > andl $-8192, %eax
> > > > > movl (%eax), %eax
> > > >
> > > > Although I'm good in assembly but bad in gas,
> > > > do you consider the middle line good style?
> > > >
> > > > Binary AND with a negative decimal number?
> > >
> > > ~N = -(N + 1)
> >
> > I know, but I don't consider this good style, as
> > decimal arithmetic is for humans, and binary
> > {arithmetic,ops} are for the PC.
>
> The better solution would be (STACK_SIZE - 1) but it's still decimal.

I agree on that, it's way more readable.

Please don't think that I'm flaming here, it's just that
a) we have a discussion on coding style
b) we don't (?) have an assembly coding style
c) gas is ugly anyway
d) but this seems really... unused

Sorry if I have offended you.

-mirabilos
-- 
C:\>debug
-e100 FA EB FC
-g
Pssssst... Don't tell anyone I'm free.......

