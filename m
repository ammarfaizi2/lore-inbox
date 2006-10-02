Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965454AbWJBV7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965454AbWJBV7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965456AbWJBV7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:59:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:12228 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965450AbWJBV7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:59:09 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
Date: Mon, 2 Oct 2006 23:59:00 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <200610022319.59029.ak@suse.de> <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610022359.00951.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2006 23:46, Linus Torvalds wrote:
> 
> On Mon, 2 Oct 2006, Andi Kleen wrote:
> > 
> > How would you test something like this? It would touch all architectures
> > and nearly all drivers too.
> 
> "If it compiles, it works".

I remember trying to compile a lot of architectures when I did 4level,
but I quickly gave up because of many of them just didn't without
me changing anything.

-Andi
