Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUILA3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUILA3M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 20:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268392AbUILA3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 20:29:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:16064 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268381AbUILA2y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 20:28:54 -0400
Date: Sat, 11 Sep 2004 17:28:25 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jon Smirl <jonsmirl@gmail.com>
cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?ISO-8859-1?Q?Felix_K=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeon-pre-2
In-Reply-To: <9e4733910409111721534b2e6d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0409111723470.2341@ppc970.osdl.org>
References: <9e47339104090919015b5b5a4d@mail.gmail.com> 
 <9e47339104091010221f03ec06@mail.gmail.com>  <1094835846.17932.11.camel@localhost.localdomain>
  <9e47339104091011402e8341d0@mail.gmail.com>  <Pine.LNX.4.58.0409102254250.13921@skynet>
  <20040911132727.A1783@infradead.org>  <9e47339104091109111c46db54@mail.gmail.com>
  <Pine.LNX.4.58.0409110939200.2341@ppc970.osdl.org> 
 <9e473391040911105448c3f089@mail.gmail.com>  <Pine.LNX.4.58.0409111058320.2341@ppc970.osdl.org>
 <9e4733910409111721534b2e6d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Sep 2004, Jon Smirl wrote:

> On Sat, 11 Sep 2004 11:13:17 -0700 (PDT), Linus Torvalds
> <torvalds@osdl.org> wrote:
> > So I'd much rather see the "hey, somebody else might have stolen my
> > hardware, and now I need to re-initialize" as the _basic_ model. That just
> > allows others to do their own thing, and play well together. More
> > importantly, it allows the existing status quo, which means that if we
> > take that as the basic approach, we _never_ have to make a complete flag
> > day when we switch over to "_this_ driver does everything". See?
> 
> We already have a mechanism for this: suspend/resume.

Jon, you're not making sense any more.

This discussion is just ridiculous, and I don't think it's worth cc'ing me 
if people can't try to work together, since I'm sadly not going to have 
time to actually implement any of this myself.

If you are claiming that we should suspend/resume the whole chip just 
because two different programs want to access it, you're just crazy. 

We clearly _do_ have different subsystems already working together 
accessign the same chip, and they are _not_ doing stupid things like you 
are suggesting. They _work_. Today. No suspend/resume involved.

That interaction has some troubles, and we're trying to _fix_ them. We're 
not trying to make idiotic statments.

Yours was a singularly idiotic statment.

		Linus
