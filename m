Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261915AbREYVSh>; Fri, 25 May 2001 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261916AbREYVSZ>; Fri, 25 May 2001 17:18:25 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:8964 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S261915AbREYVSQ>; Fri, 25 May 2001 17:18:16 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Thiago Vinhas de Moraes <tvinhas@networx.com.br>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <86256A57.0074D2BE.00@smtpnotes.altec.com>
Date: Fri, 25 May 2001 16:17:02 -0500
Subject: Re: The difference between Linus's kernel and Alan Cox's kernel
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



It really ought to be Linus and/or Alan who answers this, but from my own
observations, here's the way I think it goes:

Alan and Linus don't always agree on what should be in the kernel; and even when
they do, they sometimes disagree on when something is ready to be included.
Alan may think a particular set of patches are ready, while Linus thinks they
need to mature a bit more; or perhaps he thinks the whole approach is wrong and
should be scrapped.  So Alan puts it in his kernel, and Linus leaves it out of
his.  (Of course, sometimes it's Linus who adds something that Alan rejects.)
It sometimes happens that one of these new ideas turns out better than expected
(especially after going through a few bug report/new patch cycles), and the
person who rejected it changes his mind and includes it later; or maybe it
doesn't work out and gets dropped altogether.  Also, as you've already observed,
Alan regularly resyncs major parts of his tree with Linus' so they don't get too
far apart, and Linus occasionally does the same.

It used to bother me, too, to have to keep up with two different kernel trees.
But I've come to realize that this is a Good Thing.  It provides a way for
people with different viewpoints to approach an idea from more than one
direction.  If the two kernels are trying to solve a particular problem in
different ways, we get to see how each approach works in the real world, rather
than just in a theoretical discussion.  If the two kernels branch too far apart
it could be a problem, but Linus and Alan have been diligent about keeping that
from happening.  I think the interplay (is "competition" too strong a word?)
between the two branches has helped make the "official" kernel better than it
might have been otherwise.

Wayne


