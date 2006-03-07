Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932460AbWCGL2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbWCGL2v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWCGL2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:28:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:46555 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932460AbWCGL2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:28:50 -0500
Date: Tue, 7 Mar 2006 12:27:44 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Altenberg <tb10alj@tglx.de>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] realtime-preempt patch-2.6.15-rt19 compile error (was: realtime-preempt patch-2.6.15-rt18 issues)
Message-ID: <20060307112744.GA1369@elte.hu>
References: <45924.195.245.190.93.1141647094.squirrel@www.rncbc.org> <20060306132442.GA12359@elte.hu> <4547.195.245.190.94.1141657830.squirrel@www.rncbc.org> <440D54F2.2080009@tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440D54F2.2080009@tglx.de>
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


* Jan Altenberg <tb10alj@tglx.de> wrote:

> Hi,
> 
> > -rt19 doesn't compile here (either with CONFIG_EMBEDDED=y or not):
> 
> same problem here. Looks like a typo...
> Am I right?

> -       .spinlock = SPIN_LOCK_UNLOCKED(&cache_cache.spinlock),
> +       .spinlock = SPIN_LOCK_UNLOCKED(cache_cache.spinlock),

indeed - i've uploaded -rt20 with this fix.

	Ingo
