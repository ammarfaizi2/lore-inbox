Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319092AbSIDHlj>; Wed, 4 Sep 2002 03:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319095AbSIDHli>; Wed, 4 Sep 2002 03:41:38 -0400
Received: from dp.samba.org ([66.70.73.150]:27795 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319092AbSIDHli>;
	Wed, 4 Sep 2002 03:41:38 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Important per-cpu fix. 
In-reply-to: Your message of "Tue, 03 Sep 2002 23:19:07 MST."
             <20020903.231907.21327801.davem@redhat.com> 
Date: Wed, 04 Sep 2002 17:38:48 +1000
Message-Id: <20020904074612.BA6CE2C073@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020903.231907.21327801.davem@redhat.com> you write:
> 
> Actually Rusty what's the big deal, add an "initializer"
> arg to the macro.  It doesn't hurt anyone, it doesn't lose
> any space in the kernel image, and the macro arg reminds
> people to do it.
> 
> I think it's a small price to pay to keep a longer range
> of compilers supported :-)

I disagree.  They might not have a convenient (static) initializer, in
which case it's simply cruel and unusual, to work around an obscure
compiler bug.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
