Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUIKOi5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUIKOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 10:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267976AbUIKOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 10:38:56 -0400
Received: from the-village.bc.nu ([81.2.110.252]:11699 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267958AbUIKOiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 10:38:54 -0400
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Wedgwood <cw@f00f.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040910232826.GA3302@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org>
	 <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
	 <20040910231052.GA3078@taniwha.stupidest.org>
	 <1094854872.18282.29.camel@localhost.localdomain>
	 <20040910232826.GA3302@taniwha.stupidest.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094909793.21157.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 11 Sep 2004 14:36:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-09-11 at 00:28, Chris Wedgwood wrote:
> > > > > -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> > > > > +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
> 
> > This should really go.
> 
> do we want counters for this?  what about the APIC case?

I don't know enough about the APIC version to comment, just the PIC one.
