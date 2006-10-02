Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965428AbWJBVqw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965428AbWJBVqw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965429AbWJBVqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:46:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965428AbWJBVqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:46:50 -0400
Date: Mon, 2 Oct 2006 14:46:11 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <200610022319.59029.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0610021445570.3952@g5.osdl.org>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002140121.f588b463.akpm@osdl.org> <Pine.LNX.4.64.0610021412200.3952@g5.osdl.org>
 <200610022319.59029.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Andi Kleen wrote:
> 
> How would you test something like this? It would touch all architectures
> and nearly all drivers too.

"If it compiles, it works".

Pretty close.

		Linus
