Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbSJOFVD>; Tue, 15 Oct 2002 01:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262416AbSJOFVD>; Tue, 15 Oct 2002 01:21:03 -0400
Received: from dp.samba.org ([66.70.73.150]:16321 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262414AbSJOFVB>;
	Tue, 15 Oct 2002 01:21:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 1/7 
In-reply-to: Your message of "Fri, 27 Sep 2002 01:38:56 +0200."
             <Pine.LNX.4.44.0209261845420.338-100000@serv> 
Date: Tue, 15 Oct 2002 14:53:41 +1000
Message-Id: <20021015052656.3455E2C073@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209261845420.338-100000@serv> you write:
> I'm not completely opposed to a kernel, but completely disabling the user
> space loader is IMO not acceptable (at least not until the new loader went
> through one stable release).

Huh?  We're talking about 50 lines of code for insmod (modprobe is
harder, yes).  But risking this instability is what unstable kernels
are *for*!

You're still talking about forcing us to maintain a *very intimate*
interface in order to remove 200 lines from the kernel.  Ask Keith the
troubles of keeping modutils in sync with the kernel.  I've been
following it for about 18 months, and I haven't envied the (excellent)
job he had to do.

200 lines! 8)
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
