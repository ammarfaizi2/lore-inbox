Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbTBHGGP>; Sat, 8 Feb 2003 01:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266969AbTBHGGP>; Sat, 8 Feb 2003 01:06:15 -0500
Received: from dp.samba.org ([66.70.73.150]:9634 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266970AbTBHGGN>;
	Sat, 8 Feb 2003 01:06:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][5/6] CPU Hotplug i386 
In-reply-to: Your message of "Fri, 07 Feb 2003 18:03:41 BST."
             <20030207170030.GA2054@zaurus.ucw.cz> 
Date: Sat, 08 Feb 2003 15:26:54 +1100
Message-Id: <20030208061555.0B9832C065@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030207170030.GA2054@zaurus.ucw.cz> you write:
> Hi!
> 
> > +#ifdef CONFIG_HOTPLUG
> > +static inline void maybe_play_dead(void)
> 
> Maybe config_CPU_hotplug would be a better
> name?

Could well be, but currently it's entirely subsumed by the existing
CONFIG_HOTPLUG option.

Hope that clarifies!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
