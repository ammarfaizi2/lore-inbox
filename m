Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVKUXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVKUXDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbVKUXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 18:03:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:41674 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751240AbVKUXDR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 18:03:17 -0500
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>
In-Reply-To: <Pine.LNX.4.64.0511211429190.13959@g5.osdl.org>
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
	 <20051121213527.GA6452@elte.hu>
	 <Pine.LNX.4.64.0511211350010.13959@g5.osdl.org>
	 <1132610954.26560.46.camel@gaston>
	 <Pine.LNX.4.64.0511211429190.13959@g5.osdl.org>
Content-Type: text/plain
Date: Tue, 22 Nov 2005 10:00:29 +1100
Message-Id: <1132614030.26560.56.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> By centralizing NO_IRQ, you either have to break a lot of existing PC 
> setups, or you have to potentially break (far fewer) PowerPC setups. So 
> let's not do it at all.

I have no strong feeling vs. centralized or not centralized NO_IRQ
value. All I want is NO_IRQ to exist on all archs so I can fix the few
drivers that assume that 0 is no irq.

Ben.


