Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267655AbSKTHio>; Wed, 20 Nov 2002 02:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbSKTHio>; Wed, 20 Nov 2002 02:38:44 -0500
Received: from dp.samba.org ([66.70.73.150]:52961 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267655AbSKTHik>;
	Wed, 20 Nov 2002 02:38:40 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM kernel module loader. 
In-reply-to: Your message of "Tue, 19 Nov 2002 20:31:29 -0000."
             <20021119203128.E5535@flint.arm.linux.org.uk> 
Date: Wed, 20 Nov 2002 18:38:34 +1100
Message-Id: <20021120074545.57B1D2C085@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119203128.E5535@flint.arm.linux.org.uk> you write:
> Ok, here's the problem I'm currently facing.
> 
> KAO's insmod used to do various fixups (trampolines of 8 bytes in length)
> before inserting modules into the kernel on ARM to make sure the PC24
> branch relocations were able to reach the kernel binary image in memory.
> PC24 relocations have a maximum range of +/- 32MB, and the kernel may be
> (on current architectures) up to 256MB to 512MB away.

See PPC32, on my kernel.org page.  Exactly the same issue.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
