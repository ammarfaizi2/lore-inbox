Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLYDvq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 22:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbTLYDvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 22:51:46 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:62381 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262228AbTLYDvp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 22:51:45 -0500
Date: Thu, 25 Dec 2003 11:51:07 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Greg KH <greg@kroah.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       <ULMO@Q.NET>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up fs/devfs/base.c
In-Reply-To: <20031224171054.GB29796@kroah.com>
Message-ID: <Pine.LNX.4.44.0312251114150.3691-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003, Greg KH wrote:

> > I think it needs a little bit more than that Greg.
> 
> Oh, I know it does.  That was just a "convert to proper coding format in
> 15 minutes" patch.  You should start with that and work from there.
> But, if you are going to do this, remember to submit in incremental
> changes.  I suggest this patch go in, as it is just a reformatting,
> nothing else.  Then you can work from there, changing the actual logic
> of the code.

Yep. I have started with the patch you provided. Thanks.

I'm a bit of a white space obsessive compulsive type so I have made a fair 
few more changes. I tried hard to resist changing the code but some of 
those long lines just had to go.

I'm having difficulty resisting breaking up base.c. I just can't bare 
3000+ lines in one source file.

I'm thinking I should just go ahead, do a limited test and then get a 
couple of people that use devfs to test it before submitting it. 

Mind, I'm not changing the logic, just the layout and structure.

You don't agree I think.

I'm making patches as I go so I can do the incremental thing without being 
held up. I have the time to do this now, over the Xmas break, so I'll go 
ahead and return to fix things if I need to.

Lets not loose sight of the reason I volunteered to provide maintenance 
only, best effort only fixes during the deprecation process. That 
is, as you know, to quell the unrest on the list regarding devfs, so that 
people like yourself can get on with udev.

Simple things like replacing OBSOLETE with DEPRECATED in fs/Kconfig and 
rewording last paragraph to better reflect Andrews actual intent would 
help a lot.

So it's Xmas day and I shouldn't be so serious.
Hope everyone has a great day.
Indeed, some of us won't get to it till tomorrow, fantastic.

Ian

