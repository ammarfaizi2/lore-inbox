Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTA2E4B>; Tue, 28 Jan 2003 23:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbTA2E4B>; Tue, 28 Jan 2003 23:56:01 -0500
Received: from dp.samba.org ([66.70.73.150]:36815 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261292AbTA2E4A>;
	Tue, 28 Jan 2003 23:56:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       trivial@rustcorp.com.au, Neil Brown <neilb@cse.unsw.edu.au>,
       dwmw2@redhat.com
Subject: Re: [PATCH] [TRIVIAL] kstrdup 
In-reply-to: Your message of "Thu, 23 Jan 2003 15:02:15 BST."
             <20030123140215.GA1229@atrey.karlin.mff.cuni.cz> 
Date: Wed, 29 Jan 2003 15:51:30 +1100
Message-Id: <20030129050522.1F5E02C625@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030123140215.GA1229@atrey.karlin.mff.cuni.cz> you write:
> Hi!
> 
> > > > Everyone loves reimplementing strdup.  Give them a kstrdup (basically
> > > > from drivers/md).
> > > 
> > > I believe it would be better to call it strdup.
> > 
> > No.  Don't confuse people.
> 
> Ehm?! What's confusing on strdup? Or you want to also introduce
> kmemcpy, kmemcmp, ksprintf etc?

It has an extra argument, like kmalloc.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
