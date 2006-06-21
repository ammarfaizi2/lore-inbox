Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWFULLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWFULLL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWFULLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:11:11 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:62685 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751352AbWFULLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:11:09 -0400
Date: Wed, 21 Jun 2006 13:06:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Rigg <lk@sound-man.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rt1 unknown symbol monotonic_clock
Message-ID: <20060621110613.GA22322@elte.hu>
References: <20060621100623.GA2960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621100623.GA2960@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Rigg <lk@sound-man.co.uk> wrote:

> Just compiled 2.6.17-rt1 on x86_64 UP system and got the following
> message when doing `make modules_install':
> WARNING: /lib/modules/2.6.17-rt1/kernel/drivers/char/hangcheck-timer.ko \
> needs unknown symbol monotonic_clock

please try -rt2 - does it work any better?

	Ingo
