Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWH1K2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWH1K2G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 06:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWH1K2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 06:28:06 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:14797 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S964779AbWH1K2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 06:28:03 -0400
Subject: Re: Linux v2.6.18-rc5
From: Kasper Sandberg <lkml@metanurb.dk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nathan Scott <nathans@sgi.com>
In-Reply-To: <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 12:27:49 +0200
Message-Id: <1156760869.24904.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-28 at 12:10 +0200, Jesper Juhl wrote:
> On 28/08/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok,
> >  this was delayed three weeks due to a combination of vacations and a
> > funeral in Finland, but Greg and Andrew kept on top of things, and we were
> > fairly late in the release cycle anyway, so it hopefully caused no real
> > problems apart from obviously delaying the final release a tiny bit.
> >
> > Linux 2.6.18-rc5 is out there now, both in git form and as patches and
> > tar-balls (the latter which I forgot for -rc4, but Greg covered for me -
> > blush).
> >
> > The shortlog (appended) tells the story: various fixes all around.
> > Powerpc, V4L, networking, SCSI..
> >
> > Pls test it out, and please remind all the appropriate people about any
> > regressions you find (including any found earlier if they haven't been
> > addressed yet).
> >
> Not really a regression, more like a long standing bug, but XFS has
> issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
and you are saying this issue exists in all post .11 kernels?
> With heavy rsync load to a machine with XFS filesystems, XFS falls
> over and filesystems are in need of xfs_repair.
> I'm doing all I can to gather info for Nathan so he can fix the bug,
> but it's hard to trigger reliably.
could you please describe whatever you have found out, im eager to take
a look at it myself
> My point is that perhaps it's worth delaying 2.6.18 a little longer in
> the hope of getting that bug fixed before release. Nathan?
> At least for me, XFS in its current state (and thus 2.6.18)  is
> unusable in production environments.
> 
> See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
> kernel NULL pointer dereference at virtual address 00000078" for the
> full story.
> 

