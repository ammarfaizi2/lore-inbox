Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261174AbVFPHca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261174AbVFPHca (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 03:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbVFPHc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 03:32:29 -0400
Received: from mx1.elte.hu ([157.181.1.137]:22930 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261174AbVFPHc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 03:32:27 -0400
Date: Thu, 16 Jun 2005 09:29:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
Message-ID: <20050616072935.GB19772@elte.hu>
References: <20050608112801.GA31084@elte.hu> <42B0F72D.5040405@cybsft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B0F72D.5040405@cybsft.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* K.R. Foley <kr@cybsft.com> wrote:

> Having problems with -RT-2.6.12-rc6-V0.7.48-33 booting on my older SMP 
> system (dual 933). Looking at the log apic.log it indicates a problem 
> with APIC. noapic.log is a log when I add "noapic" to the boot 
> parameters.

could you uncomment the IO_APIC_CACHE define in 
arch/i386/kernel/io_apic.c, and could you uncomment line 1109 in 
drivers/ide/ide-io.c - does this fix things? (in apic mode)

	Ingo
