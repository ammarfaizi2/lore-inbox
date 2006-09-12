Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWILF7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWILF7p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWILF7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:59:45 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38802 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751314AbWILF7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:59:44 -0400
Date: Tue, 12 Sep 2006 07:51:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386-pda: Initialize the PDA early, before any C code runs.
Message-ID: <20060912055132.GA24298@elte.hu>
References: <4505E8C1.7010906@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505E8C1.7010906@goop.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> In the process, this removes the need for early_smp_processor_id() and
> early_current().
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Cc: Ingo Molnar <mingo@elte.hu>

looks good to me.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
