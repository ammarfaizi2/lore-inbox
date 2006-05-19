Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWESJcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWESJcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWESJcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:32:04 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:9374 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751300AbWESJcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:32:02 -0400
Date: Fri, 19 May 2006 11:31:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [patchset] Generic IRQ Subsystem: -V4
Message-ID: <20060519093146.GA8364@elte.hu>
References: <20060517001310.GA12877@elte.hu> <20060517221536.GA13444@elte.hu> <200605190024.53879.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605190024.53879.ioe-lkml@rameria.de>
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


* Ingo Oeser <ioe-lkml@rameria.de> wrote:

> Hi Ingo,
> 
> just a minor nit.
> 
> On Thursday, 18. May 2006 00:15, Ingo Molnar wrote:
> > - sem2mutex: kernel/irq/autoprobe.c probe_sem => probe_lock mutex 
> >   conversion.
> 
> Please call this probe_mutex. probe_lock would suggest, that this is a 
> spin_lock() when people talk about it.

i renamed it to "probing_active", which describes its purpose even 
better. Ok?

	Ingo
