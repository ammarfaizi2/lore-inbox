Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266968AbTBUAah>; Thu, 20 Feb 2003 19:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBUAah>; Thu, 20 Feb 2003 19:30:37 -0500
Received: from dp.samba.org ([66.70.73.150]:29112 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266968AbTBUAaf>;
	Thu, 20 Feb 2003 19:30:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: John Levon <levon@movementarian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module load profile hook 
In-reply-to: Your message of "Thu, 20 Feb 2003 21:53:17 -0000."
             <20030220215317.GA80769@compsoc.man.ac.uk> 
Date: Fri, 21 Feb 2003 11:33:46 +1100
Message-Id: <20030221004042.22EC12C117@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030220215317.GA80769@compsoc.man.ac.uk> you write:
> 
> Any problems with this Rusty ? It's at load time rather than
> unload as it helps userspace a little wrt reading /proc/modules

Sure, but I think I prefer a more generic notifier mechanism anyway,
which oprofile can use as well as other mechanisms.

Say, module_notifier with a MODULE_LOADED, MODULE_INITIALIZED,
MODULE_UNLOADING, MODULE_GONE?

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
