Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268365AbTBNL4f>; Fri, 14 Feb 2003 06:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268366AbTBNL4f>; Fri, 14 Feb 2003 06:56:35 -0500
Received: from dp.samba.org ([66.70.73.150]:43496 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268365AbTBNL4e>;
	Fri, 14 Feb 2003 06:56:34 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Werner Almesberger <wa@almesberger.net>, kuznet@ms2.inr.ac.ru,
       davem@redhat.com, kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Migrating net/sched to new module interface 
In-reply-to: Your message of "Fri, 14 Feb 2003 12:16:54 BST."
             <Pine.LNX.4.44.0302141035270.1336-100000@serv> 
Date: Fri, 14 Feb 2003 23:04:13 +1100
Message-Id: <20030214120628.208112C464@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302141035270.1336-100000@serv> you write:
> It's not the same, please see: 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=104284223130775&w=2
> I explained why the current module locking is more complex and why it's 
> actually a three stage delete.

No, here is where you show *your* ignorance of kernel locking idioms,
and that your axiom is that "the new system is more complex".

I suggest you read the kernel locking guide: it's in the kernel
sources in Documentation/DocBook/kernel-locking.*, try "make psdocs".

> Rusty, above are real problems, the module locking fixes these problems 
> during module_init/module_exit, but how can these problems fixed in the 
> other cases and how does the module locking help?

This isn't even a sensible question: "This is not a module problem.
How does module locking help?"

You're wasting your own valuable time, too.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
