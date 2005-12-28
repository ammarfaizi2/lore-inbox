Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932198AbVL1RJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVL1RJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 12:09:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbVL1RJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 12:09:32 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:36516 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932198AbVL1RJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 12:09:31 -0500
Date: Wed, 28 Dec 2005 18:09:11 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nicolas Pitre <nico@cam.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 1/3] mutex subsystem: trylock
Message-ID: <20051228170911.GB21451@elte.hu>
References: <20051223161649.GA26830@elte.hu> <Pine.LNX.4.64.0512261411530.1496@localhost.localdomain> <20051227115129.GB23587@elte.hu> <Pine.LNX.4.64.0512271439380.3309@localhost.localdomain> <20051228074857.GA4600@elte.hu> <20051228081348.GA6910@elte.hu> <Pine.LNX.4.64.0512281101510.3309@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512281101510.3309@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nicolas Pitre <nico@cam.org> wrote:

> > the patch below adds it, and it boots fine on x86 with mutex.c hacked to 
> > include asm-generic/mutex-xchg.h.
> 
> Here's an additional patch to fix some comments, and to add a small 
> optimization.

thanks, applied.

	Ingo
