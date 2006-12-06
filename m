Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935864AbWLFPzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935864AbWLFPzq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936127AbWLFPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:55:46 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51294 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935864AbWLFPzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:55:45 -0500
Date: Wed, 6 Dec 2006 16:54:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt 0/3] Make trace_freerunning work; Take 2
Message-ID: <20061206155457.GA9021@elte.hu>
References: <20061205220257.1AECF3E2420@elvis.elte.hu> <20061205221046.GB20587@elte.hu> <200612061608.24556.fzu@wemgehoertderstaat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061608.24556.fzu@wemgehoertderstaat.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.3 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Karsten Wiese <fzu@wemgehoertderstaat.de> wrote:

> Following 3 patches try to implement the above.
> 
> Tested on a UP only after this incantation:
> 	echo 0 > /proc/sys/kernel/wakeup_timing
> 	echo 1 > /proc/sys/kernel/trace_enabled
> 	echo 1 > /proc/sys/kernel/trace_user_triggered
> 
> and for half of tests:
> 	echo 1 > /proc/sys/kernel/trace_freerunning
> or
> 	echo 0 > /proc/sys/kernel/trace_freerunning
> .

thanks - nice work! I have applied all 3 of them and it worked fine for 
a couple of simple tests on my box too.

	Ingo
