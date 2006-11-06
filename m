Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423245AbWKFDQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423245AbWKFDQi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 22:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423265AbWKFDQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 22:16:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20958 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423245AbWKFDQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 22:16:37 -0500
Date: Sun, 5 Nov 2006 19:13:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
In-Reply-To: <1162781764.28571.275.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0611051911190.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain> 
 <20061104140559.GC19760@flint.arm.linux.org.uk>  <1162678639.28571.63.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org> 
 <1162689005.28571.118.camel@localhost.localdomain> 
 <1162697533.28571.131.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>  <1162699255.28571.150.camel@localhost.localdomain>
  <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org> 
 <1162701537.28571.156.camel@localhost.localdomain> 
 <Pine.LNX.4.64.0611042054210.25218@g5.osdl.org>  <1162703335.28571.159.camel@localhost.localdomain>
  <1162704529.28571.164.camel@localhost.localdomain>
 <1162781764.28571.275.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Nov 2006, Benjamin Herrenschmidt wrote:
> 
> In fact, you might want to push it to 2.6.19 since it fixes a bug
> (current _be operations are incorrect for PIO without the patch).

Well, I doubt anybody uses them (or we'd have seen the problem), and more 
importantly, I've already blown the patch away. If you think it's easier 
for you to sync up later, though, I'll happily apply it. Mind sending it 
back to me with a Tested-by: line or something? I literally didn't even 
compile-test the thing, and blew that file away after I had generated the 
trial patch.

		Linus
