Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754551AbWKHMG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbWKHMG3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 07:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754549AbWKHMG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 07:06:29 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:64137 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1754548AbWKHMG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 07:06:28 -0500
Date: Wed, 8 Nov 2006 13:05:25 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: mm-commits@vger.kernel.org, tglx@linutronix.de,
       Andrew Morton <akpm@osdl.org>
Subject: Re: + i386-apic-cleanup.patch added to -mm tree
Message-ID: <20061108120525.GA19843@elte.hu>
References: <200611012045.kA1KjIdp018937@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611012045.kA1KjIdp018937@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* akpm@osdl.org <akpm@osdl.org> wrote:

> Subject: i386/apic: Code cleanup, comment fixes
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The apic code is quite unstructured and missing a lot of comment.
> 
> - Restructure the code into helper functions, timer, setup/shutdown,
>   interrupt and power management blocks. 
> - Fixup comments.
> - Namespace fixups
> - Inline helpers for version and is_integrated
> - Combine the ack_bad_irq functions
> 
> No functional changes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>

very nice cleanup!

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
