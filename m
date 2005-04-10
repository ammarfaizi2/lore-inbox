Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVDJB57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVDJB57 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 21:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVDJB57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 21:57:59 -0400
Received: from zproxy.gmail.com ([64.233.162.200]:57116 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261182AbVDJB54 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 21:57:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=hbCqqtvrY+q/eR0hvd0Zzrhteg50ckfAwZXwMzHV8zTvhoHeBaZ7OzTUwNa01X+UmA3Wj137wZ2gsY2Nce3dh4i1jAJ5bpz3wH+25C65jGIs3NZD5KxUlkOcxqegz6crPAtgtkUGVb27Z/ZPRaZr/jMeZljp+KK3P9VFwF+3DLQ=
Message-ID: <cce9e37e050409185728a8659e@mail.gmail.com>
Date: Sun, 10 Apr 2005 02:57:53 +0100
From: Phillip Lougher <phil.lougher@gmail.com>
Reply-To: Phillip Lougher <phil.lougher@gmail.com>
To: Phillip Lougher <phil.lougher@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, ross@jose.lug.udel.edu,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, pasky@ucw.cz
Subject: Re: Re: Re: Kernel SCM saga..
In-Reply-To: <20050410014259.GC9052@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050408041341.GA8720@taniwha.stupidest.org>
	 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	 <20050408071720.GA23128@jose.lug.udel.edu>
	 <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	 <20050409025357.GA9052@pasky.ji.cz>
	 <cce9e37e05040918012ef0f7ab@mail.gmail.com>
	 <20050410014259.GC9052@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 10, 2005 2:42 AM, Petr Baudis <pasky@ucw.cz> wrote:
> Dear diary, on Sun, Apr 10, 2005 at 03:01:12AM CEST, I got a letter
> where Phillip Lougher <phil.lougher@gmail.com> told me that...
> > On Apr 9, 2005 3:53 AM, Petr Baudis <pasky@ucw.cz> wrote:
> >
> > >   FWIW, I made few small fixes (to prevent some trivial usage errors to
> > > cause cache corruption) and added scripts gitcommit.sh, gitadd.sh and
> > > gitlog.sh - heavily inspired by what already went through the mailing
> > > list. Everything is available at http://pasky.or.cz/~pasky/dev/git/
> > > (including .dircache, even though it isn't shown in the index), the
> > > cumulative patch can be found below. The scripts aim to provide some
> > > (obviously very interim) more high-level interface for git.
> >
> > I did a bit of playing about with the changelog generate script,
> > trying to produce a faster version.  The attached version uses a
> > couple of improvements to be a lot faster (e.g. no recursion in the
> > common case of one parent).
> >
> > FWIW it is 7x faster than makechlog.sh (4.342 secs vs 34.129 secs) and
> > 28x faster than gitlog.sh (4.342 secs vs 2 mins 4 secs) on my
> > hardware.  You mileage may of course vary.
> 
> Wow, really impressive! Great work, I've merged it (if you don't object,
> of course).

Of course I don't object...

> 
> Wondering why I wasn't in the Cc list, BTW.

Weird, it wasn't intentional.  I read LKML in Gmail (which I don't use
for much else), and just clicked "reply", expecting to do the right
thing.  Replying to this email it's also left you off the CC list. 
Looking at the email source I believe it's probably to do with the
following:

Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	ross@jose.lug.udel.edu,
	Kernel Mailing List <linux-kernel@vger.kernel.org>> 

I've CC'd you explicitly on this.

Phillip
