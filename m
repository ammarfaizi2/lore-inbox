Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964888AbWH1Xab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWH1Xab (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 19:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWH1Xaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 19:30:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:11426 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964888AbWH1Xaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 19:30:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXPIBfkN2CXa0Eq3v5keC4Ia8nWlulyoTTOW5QlFA7s+u8h+ILua3fSAsxLGCg1PVUEpqkC27mYeTU66idTvxoN+WVr/ieW13dg0FOGgHx+UPYq/YfmezmalVw8q4VUVBv+cXewliBabZZ+5zNN0+gdD8eTe2slcZi0GJ4Kxgyo=
Message-ID: <9a8748490608281630v26db3164y4f104d13a3b201b6@mail.gmail.com>
Date: Tue, 29 Aug 2006 01:30:29 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nathan Scott" <nathans@sgi.com>
Subject: Re: Linux v2.6.18-rc5
Cc: "Kasper Sandberg" <lkml@metanurb.dk>, "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060829083643.A3150749@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	 <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com>
	 <1156760869.24904.1.camel@localhost>
	 <9a8748490608280335w4474b489u45b3b0b05b7f2f44@mail.gmail.com>
	 <20060829083643.A3150749@wobbly.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/06, Nathan Scott <nathans@sgi.com> wrote:
> On Mon, Aug 28, 2006 at 12:35:00PM +0200, Jesper Juhl wrote:
> > On 28/08/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > > On Mon, 2006-08-28 at 12:10 +0200, Jesper Juhl wrote:
> > > > Not really a regression, more like a long standing bug, but XFS has
> > > > issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
> > > and you are saying this issue exists in all post .11 kernels?
>
> I would be surprised if this is not a day one bug, it probably
> even affects the IRIX version of XFS.  Our problem is the lack
> of a test case to find it - my efforts have come to naught so
> far.  I'm having to cross my fingers that Jesper can extract a
> bit more information when he's next able to hit it.
>
I'm trying my best, but it's difficult. Often I can only run the -rc
kernel for a few hours on the box that currently shows the problem,
and that's not enough to hit the fault.
I've configured a XFS partition on my home workstation and I'm keeping
that one busy doing various rsync's and running benchmarks etc -
putting as much different stress on the XFS filesystem as I can. I'm
also setting up a test box at work to try and duplicate the problem on
a non-production server. I won't be able to duplicate the setup
exactly, but it'll be close.

> > > > See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
> > > > kernel NULL pointer dereference at virtual address 00000078" for the
> > > > full story.
>
> That, and another story - Jesper hijacked that thread ;) - the

Sorry ;)

> inital bug there was found and fixed, and the fix has now been
> merged.  But (fyi, Kasper) much of that thread is discussing a
> different bug to this one.
>

True. I should have emphasised that.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
