Return-Path: <linux-kernel-owner+w=401wt.eu-S1751649AbXANT5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbXANT5I (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751653AbXANT5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:57:08 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37110 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650AbXANT5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:57:07 -0500
Date: Sun, 14 Jan 2007 20:52:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dave Jones <davej@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] lockdep: shrink held_lock structure
Message-ID: <20070114195231.GA22911@elte.hu>
References: <20070102233558.GA4577@redhat.com> <20070102233824.GF18033@redhat.com> <1168800350.32239.13.camel@earth> <20070114194217.GA20726@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070114194217.GA20726@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0001]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> Subject: [patch] lockdep: shrink held_lock structure
> From: Dave Jones <davej@redhat.com>
> 
> shrink the held_lock structure from 40 to 20 bytes. This shrinks struct 
> task_struct from 3056 to 2464 bytes.
> 
> [ From: Ingo Molnar <mingo@elte.hu>, shrunk hlock->class too. ]

doh - some buglet sneaked into the hlock->class_idx change ... 
investigating it. Ignore this patch for now.

	Ingo
