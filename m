Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264946AbSLBFif>; Mon, 2 Dec 2002 00:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264945AbSLBFie>; Mon, 2 Dec 2002 00:38:34 -0500
Received: from dp.samba.org ([66.70.73.150]:50333 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264943AbSLBFid>;
	Mon, 2 Dec 2002 00:38:33 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: tomlins@cam.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ALPHA RELEASE] module-init-tools 0.9-alpha 
In-reply-to: Your message of "Sun, 01 Dec 2002 22:20:57 CDT."
             <20021202032057.60AB1EC3@oscar.casa.dyndns.org> 
Date: Mon, 02 Dec 2002 16:43:59 +1100
Message-Id: <20021202054602.2CB522C06B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021202032057.60AB1EC3@oscar.casa.dyndns.org> you write:
> I just built and installed 0.9-beta.  First it tried to install into 
> /usr/local/sbin which is pretty useless here.  Fix this with --prefix=
> and tried again.  This time it put things in /sbin as expected, but did
> not rename the old files with a .old suffix.  Should this still happen?
> If not, what happened with backwards compat?

First line of the README:

READ INSTRUCTIONS CAREFULLY, OTHERWISE YOU MAY DESTROY YOUR OLD UTILS!

Reinstall your old modutils, then read the README.

There's a "check-destroy-old" target in Makefile.am, I'm just trying
to figure out how to get autoconf to run it before the install target.

You're probably thinking I should fix this ASAP, and I think you're
right 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
