Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267485AbSLSAgg>; Wed, 18 Dec 2002 19:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267492AbSLSAgg>; Wed, 18 Dec 2002 19:36:36 -0500
Received: from dp.samba.org ([66.70.73.150]:64745 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267485AbSLSAgg>;
	Wed, 18 Dec 2002 19:36:36 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: vamsi@in.ibm.com, Zwane Mwaikambo <zwane@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-' 
In-reply-to: Your message of "Wed, 18 Dec 2002 11:47:26 MDT."
             <Pine.LNX.4.44.0212181144120.21707-100000@chaos.physics.uiowa.edu> 
Date: Thu, 19 Dec 2002 11:39:24 +1100
Message-Id: <20021219004437.23CE82C055@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0212181144120.21707-100000@chaos.physics.uiowa.edu> y
ou write:
> On Wed, 18 Dec 2002, Rusty Russell wrote:
> > Has there ever been a simple way?
> 
> Well, you can do
> 
> cd my_module
> echo "obj-m := my_module.o" > Makefile
> vi my_module.c
> make -C <path/to/kernel/src> SUBDIRS=$PWD modules
> 
> That's not too bad (and basically works for 2.4 as well)

And then you're independent of changes in the build system, too.  I
like it.

Thanks for the tip!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
