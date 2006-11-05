Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWKEFJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWKEFJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 00:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWKEFJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 00:09:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:48300 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030220AbWKEFJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 00:09:27 -0500
Subject: Re: lib/iomap.c mmio_{in,out}s* vs. __raw_* accessors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>
In-Reply-To: <Pine.LNX.4.64.0611042054210.25218@g5.osdl.org>
References: <1162626761.28571.14.camel@localhost.localdomain>
	 <20061104140559.GC19760@flint.arm.linux.org.uk>
	 <1162678639.28571.63.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041544030.25218@g5.osdl.org>
	 <1162689005.28571.118.camel@localhost.localdomain>
	 <1162697533.28571.131.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611041946020.25218@g5.osdl.org>
	 <1162699255.28571.150.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611042013400.25218@g5.osdl.org>
	 <1162701537.28571.156.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611042054210.25218@g5.osdl.org>
Content-Type: text/plain
Date: Sun, 05 Nov 2006 16:08:55 +1100
Message-Id: <1162703335.28571.159.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Can you work based on something like this instead?
> 
> (Totally untested, I just did this as an example of what I think is a lot 
> more maintainable)

Yup, that would definitely work for me.

I'll do the same for the repeat ops..

Thanks,
Ben.


