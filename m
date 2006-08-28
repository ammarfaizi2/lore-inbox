Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWH1WhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWH1WhU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 18:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWH1WhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 18:37:20 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16095 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964872AbWH1WhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 18:37:18 -0400
Date: Tue, 29 Aug 2006 08:36:43 +1000
From: Nathan Scott <nathans@sgi.com>
To: Kasper Sandberg <lkml@metanurb.dk>, Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc5
Message-ID: <20060829083643.A3150749@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org> <9a8748490608280310q65c1335cr2603b044c340a489@mail.gmail.com> <1156760869.24904.1.camel@localhost> <9a8748490608280335w4474b489u45b3b0b05b7f2f44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9a8748490608280335w4474b489u45b3b0b05b7f2f44@mail.gmail.com>; from jesper.juhl@gmail.com on Mon, Aug 28, 2006 at 12:35:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 12:35:00PM +0200, Jesper Juhl wrote:
> On 28/08/06, Kasper Sandberg <lkml@metanurb.dk> wrote:
> > On Mon, 2006-08-28 at 12:10 +0200, Jesper Juhl wrote:
> > > Not really a regression, more like a long standing bug, but XFS has
> > > issues in 2.6.18-rc* (and earlier kernels, at least post 2.6.11).
> > and you are saying this issue exists in all post .11 kernels?

I would be surprised if this is not a day one bug, it probably
even affects the IRIX version of XFS.  Our problem is the lack
of a test case to find it - my efforts have come to naught so
far.  I'm having to cross my fingers that Jesper can extract a
bit more information when he's next able to hit it.

> > > See the thread titled "2.6.18-rc3-git3 - XFS - BUG: unable to handle
> > > kernel NULL pointer dereference at virtual address 00000078" for the
> > > full story.

That, and another story - Jesper hijacked that thread ;) - the
inital bug there was found and fixed, and the fix has now been
merged.  But (fyi, Kasper) much of that thread is discussing a
different bug to this one.

cheers.

-- 
Nathan
