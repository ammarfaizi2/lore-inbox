Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319487AbSIMBvL>; Thu, 12 Sep 2002 21:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319484AbSIMBuT>; Thu, 12 Sep 2002 21:50:19 -0400
Received: from dp.samba.org ([66.70.73.150]:12240 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319486AbSIMBuK>;
	Thu, 12 Sep 2002 21:50:10 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Generated files destruction 
In-reply-to: Your message of "Thu, 12 Sep 2002 15:53:45 EST."
             <Pine.LNX.4.44.0209121551010.31494-100000@chaos.physics.uiowa.edu> 
Date: Fri, 13 Sep 2002 10:42:08 +1000
Message-Id: <20020913015502.29C4E2C08B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0209121551010.31494-100000@chaos.physics.uiowa.edu> y
ou write:
> On Thu, 12 Sep 2002, Rusty Russell wrote:
> 
> > 	I would like to start migrating all build-generated files to
> > names matching "generated*" or ".generated*", esp. those which look
> > like source files.  This is mainly for readability and for simplicity
> > when diffing built kernel trees.  I'll be encouraging various
> > maintainers who generate (.c, .h and .s) files which are not meant to
> > be shipped with the kernel source to migrate, in my copious free
> > time...
> 
> I think the proper solution here is actually separate obj/src dirs, 
> instead of special names. It's actually quite easy to get that implemented 
> in the current kbuild, I just didn't find the time for proper testing yet. 
> I'll have a patch ready for testing soon, though.

Sure, if it basically comes for free.  Otherwise, I don't see any
attraction in separating them: cp -al linux-2.5.34 working-2.5.34-foo
takes a couple of seconds.

Cheers!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
