Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVBTMAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVBTMAL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 07:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVBTMAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 07:00:11 -0500
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:48517 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261821AbVBTMAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 07:00:06 -0500
Subject: Re: IBM Thinkpad G41 PCMCIA problems [Was: Yenta TI: ... no PCI
	interrupts. Fish. Please report.]
From: Steven Rostedt <rostedt@goodmis.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>
In-Reply-To: <20050220102037.C9509@flint.arm.linux.org.uk>
References: <1108858971.8413.147.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0502191648110.14176@ppc970.osdl.org>
	 <1108863372.8413.158.camel@localhost.localdomain>
	 <20050220082226.A7093@flint.arm.linux.org.uk>
	 <20050220102037.C9509@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sun, 20 Feb 2005 06:59:38 -0500
Message-Id: <1108900778.8413.173.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-02-20 at 10:20 +0000, Russell King wrote:

> BTW, try passing:
> 
> 	reserve=0x3fefa000,0x6000
> 
> to the kernel - this will mark the "hole" reserved and should reallocate
> the resources which are clashing with the RAM.
> 
I just  tried this on 2.6.9 (with no patches) and it worked. So I think
Russ is right.

I guess the problem arises when you have an IBM G41 Thinkpad with a Gig
of RAM.

Linus,

How much RAM is on your machine?

-- Steve



