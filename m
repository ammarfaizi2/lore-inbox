Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbVK2QjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbVK2QjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 11:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbVK2QjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 11:39:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48022 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932140AbVK2QjC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 11:39:02 -0500
Date: Tue, 29 Nov 2005 08:38:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Krufky <mkrufky@m1k.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc3
In-Reply-To: <438C80DD.7050809@m1k.net>
Message-ID: <Pine.LNX.4.64.0511290835220.3177@g5.osdl.org>
References: <Pine.LNX.4.64.0511282006370.3177@g5.osdl.org> <438C0124.3030700@m1k.net>
 <Pine.LNX.4.64.0511290808510.3177@g5.osdl.org> <438C80DD.7050809@m1k.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 29 Nov 2005, Michael Krufky wrote:
> 
> In other words, the OOPS is the last thing to show on the screen in text mode,
> before the console switches into X, using debian sarge's default bootup
> process.

Ok. Whatever it is, I'm happy it is doing that, since it caused us to see 
the oops quickly. None of _my_ boxes do that, obviously (and I tested on 
x86, x86-64 and ppc64 exactly to get reasonable coverage of what different 
architectures might do - but none of the boxes are debian-based).

> I have no idea why gdb is running.... hmm... Anyhow, I'm away from that
> machine right now, and it is powered off, so I can't look directly at the
> startup scripts right now.  Would you like me to send more info later on when
> I get home?  If so, what would you like to see?

It's not important, I was just curious about what strange things people 
have in their bootup scripts.  If you can just grep through the rc.d files 
to see what uses gdb, I'd just like to know...

		Linus
