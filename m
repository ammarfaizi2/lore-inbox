Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266261AbUA2AcO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 19:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUA2AcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 19:32:14 -0500
Received: from dp.samba.org ([66.70.73.150]:15491 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266261AbUA2AcM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 19:32:12 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, torvalds@osdl.org,
       stern@rowland.harvard.edu, greg@kroah.com, linux-kernel@vger.kernel.org,
       mochel@digitalimplant.org
Subject: Re: PATCH: (as177) Add class_device_unregister_wait() and platform_device_unregister_wait() to the driver model core 
In-reply-to: Your message of "Wed, 28 Jan 2004 03:36:03 BST."
             <Pine.LNX.4.58.0401280304180.7851@serv> 
Date: Wed, 28 Jan 2004 14:54:21 +1100
Message-Id: <20040129003227.2522C2C254@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.58.0401280304180.7851@serv> you write:
> Hi Rusty,
> 
> On Wed, 28 Jan 2004, Rusty Russell wrote:
> 
> > > Fixing this requires changing every single module, but in the end it
> > > would be worth it, as it avoids the duplicated protection and we had
> > > decent module unload semantics.
> >
> > And I still disagree. <shrug>
> 
> And I still don't know why. :(

Exactly.  So we have this same conversation over and over.  It's the
single most frustrating experience I've ever had in kernel
development. 8( I was very disappointed you didn't make it to the
kernel summit.

> Well, the problem is that this won't be an one man show, it requires that
> a number of kernel hackers understand the problem and the possible
> solutions are discussed beforehand. I can understand that a lot here are
> scared of such big change, but either we either continue complaining about
> module unloading or we do something about it and this requires exploring
> the various possibilities.

Even if the perfect scheme were achieved, I don't think Linus would
accept changing every module.  I was originally agitating for a
"perfect" solution, so few of us cared.

Linus has said it simply isn't important.  Many kernel developers
basically agree.

> Rusty, you are the modules maintainer, you are supposed to understand
> these issues, if you already block a discussion like that, what am I
> supposed to expect from others?

I'm sorry.  I tried to stay out of these discussions (hey maybe
someone will come up with a great solution!), but when Linus posted
something which was basically incorrect, I felt I had to clear the
record.

For me, this issue long ago used up its timeslice.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
