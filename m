Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266796AbTBQFH3>; Mon, 17 Feb 2003 00:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266806AbTBQFH3>; Mon, 17 Feb 2003 00:07:29 -0500
Received: from dp.samba.org ([66.70.73.150]:3458 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S266796AbTBQFH2>;
	Mon, 17 Feb 2003 00:07:28 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Brian Gerst <bgerst@didntduck.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Move __this_module to xxx.mod.c 
In-reply-to: Your message of "Sun, 16 Feb 2003 22:26:48 MDT."
             <Pine.LNX.4.44.0302162225420.5217-100000@chaos.physics.uiowa.edu> 
Date: Mon, 17 Feb 2003 15:53:28 +1100
Message-Id: <20030217051727.6778B2C0AD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302162225420.5217-100000@chaos.physics.uiowa.edu> yo
u write:
> On Mon, 17 Feb 2003, Rusty Russell wrote:
> 
> > I don't think so: the symbol will be in the module by the time
> > module-init-tools gets to it, or am I missing something?
> 
> Yes, but modprobe will look for .gnu.linkonce.__this_module if it wants to 
> change the name (but that's now in ___this_module).

Good point.  The name change thing is a known hack, of course, but
will fix userspace.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
