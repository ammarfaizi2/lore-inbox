Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbVKUVjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbVKUVjJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750993AbVKUVjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:39:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12446 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750978AbVKUVjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:39:07 -0500
Date: Mon, 21 Nov 2005 13:38:03 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
In-Reply-To: <1132607776.26560.23.camel@gaston>
Message-ID: <Pine.LNX.4.64.0511211336440.13959@g5.osdl.org>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain> 
 <24299.1132571556@warthog.cambridge.redhat.com>  <20051121121454.GA1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>  <20051121190632.GG1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>  <20051121194348.GH1598@parisc-linux.org>
  <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <1132607776.26560.23.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, Benjamin Herrenschmidt wrote:
> 
> > The fact is, 0 _is_ special. Not just for hardware, but because 0 has a 
> > magical meaning as "false" in the C language.
> 
> I don't agree, irq 0 has been a valid irq on a number of platforms for
> ages

The point is, it's _not_ a valid irq for 99.9% of all machines and drivers 
that have ever been tested.

Also, if you don't agree that 0 is special in the C language, then you're 
just strictly _wrong_. It's an undeniable fact that zero _is_ special.

		Linus
