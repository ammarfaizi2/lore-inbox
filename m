Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUJBJ6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUJBJ6v (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 05:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267382AbUJBJ6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 05:58:51 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:41603 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267378AbUJBJ6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 05:58:45 -0400
Date: Sat, 2 Oct 2004 12:00:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adrian Bunk <adrian.bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>
Subject: Re: [patch] 2.6.9-rc3-mm1: X86_LOCAL_APIC compile error
Message-ID: <20041002100023.GA10609@elte.hu>
References: <20041002014352.2b55e98d.akpm@osdl.org> <20041002095609.GA2470@stusta.mhn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002095609.GA2470@stusta.mhn.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Adrian Bunk <adrian.bunk@stusta.de> wrote:

> > +generic-irq-subsystem-x86-port.patch
> >...
> >  IRQ handling code consolidation
> >...
> 
> 
> This causes the following compile error with X86_LOCAL_APIC=y:

> The following patch fixes this issue:
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

thanks. I compiled UP+noapic and SMP+APIC but not UP-APIC variants.

	Ingo
