Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSKNECa>; Wed, 13 Nov 2002 23:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263589AbSKNEC3>; Wed, 13 Nov 2002 23:02:29 -0500
Received: from dp.samba.org ([66.70.73.150]:62417 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262859AbSKNEC1>;
	Wed, 13 Nov 2002 23:02:27 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-reply-to: Your message of "Wed, 13 Nov 2002 22:18:59 CDT."
             <Pine.LNX.4.44.0211132217580.24523-100000@montezuma.mastecende.com> 
Date: Thu, 14 Nov 2002 16:08:30 +1100
Message-Id: <20021114040920.CF9B82C0F7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0211132217580.24523-100000@montezuma.mastecende.com> 
you write:
> On Thu, 14 Nov 2002, Rusty Russell wrote:
> 
> > It is bloody convoluted.  Hmm, the arch needs to wait before returning
> > "success" on __cpu_up.
> 
> What if the processor never comes up? Whats wrong with doing this async?

What's wrong with doing it sync?  Are you in a hurry? 8)

That's what the return code is *for*...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
