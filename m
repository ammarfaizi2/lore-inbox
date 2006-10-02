Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965392AbWJBVUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbWJBVUR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965283AbWJBVUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:20:17 -0400
Received: from cantor2.suse.de ([195.135.220.15]:6592 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965202AbWJBVUP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:20:15 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 23:19:59 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002140121.f588b463.akpm@osdl.org> <Pine.LNX.4.64.0610021412200.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610021412200.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610022319.59029.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 23:12, Linus Torvalds wrote:
> 
> On Mon, 2 Oct 2006, Andrew Morton wrote:
> > 
> > Whimper.   Later in the week, please.
> 
> Sure. Somebody send me a (tested) version that works against pure -rc1, 
> and we're set to go.

How would you test something like this? It would touch all architectures
and nearly all drivers too.

-Andi
