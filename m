Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVKUVxj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVKUVxj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 16:53:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbVKUVxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 16:53:39 -0500
Received: from gate.crashing.org ([63.228.1.57]:38857 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750997AbVKUVxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 16:53:38 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
References: <E1Ee0G0-0004CN-Az@localhost.localdomain>
	 <24299.1132571556@warthog.cambridge.redhat.com>
	 <20051121121454.GA1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org>
	 <20051121190632.GG1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org>
	 <20051121194348.GH1598@parisc-linux.org>
	 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org>
	 <20051121211544.GA4924@elte.hu>
	 <17282.15177.804471.298409@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 08:50:57 +1100
Message-Id: <1132609858.26560.36.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-22 at 08:25 +1100, Paul Mackerras wrote:
> Ingo Molnar writes:
> 
> > is there any architecture where irq 0 is a legitimate setting that could 
> > occur in drivers, and which would make NO_IRQ define of 0 non-practical?  
> 
> Yes, G5 powermacs have the SATA controller on irq 0.  So if we can't
> use irq 0, I can't get to my hard disk. :)  Other powermacs also use
> irq 0 for various things, as do embedded PPC machines.

And other non-ppc embedded things I've seen in the past... I think it's
quite common outside of the x86 world

Ben.


