Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbTGCBIu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 21:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbTGCBIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 21:08:50 -0400
Received: from dp.samba.org ([66.70.73.150]:47847 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265476AbTGCBIs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 21:08:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ray Bryant <raybry@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: Bug in __pollwait() can cause select() and poll() to hang in 2.4.22-pre2 -- second try 
In-reply-to: Your message of "Wed, 02 Jul 2003 13:06:07 EST."
             <3F031F0F.4020600@sgi.com> 
Date: Thu, 03 Jul 2003 10:56:40 +1000
Message-Id: <20030703012314.888742C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3F031F0F.4020600@sgi.com> you write:
> Duh.  My fault.  I didn't see this in 2.4.22-pre2.  Some checking shows 
> that it is also in 2.4.20.  How this didn't get into our SGI 2.4.20 tree 
> is beyond me (this where we originally found this problem).  So there is 
> no problem in 2.4.22-pre2.
> 
> Rusty -- thanks for your perseverence on this.

Hey, glad I could help.

As for perseverance, it's an occupational hazard.  Linus has said
before that he doesn't want patches which don't get aggressively
pushed by someone, and indeed, they get lost.  Hence the Trivial Patch
Monkey...

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
