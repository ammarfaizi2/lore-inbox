Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWCMJGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWCMJGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbWCMJGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:06:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:12168 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932171AbWCMJGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:06:41 -0500
Date: Mon, 13 Mar 2006 10:04:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][1/4] sched: store weighted load on up
Message-ID: <20060313090412.GA5780@elte.hu>
References: <200603131905.17349.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131905.17349.kernel@kolivas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.8 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> Modify the smp nice code to store load_weight on uniprocessor as well 
> to allow relative niceness on one cpu to be assessed. Minor cleanups 
> and uninline set_load_weight().
> 
> Signed-off-by: Con Kolivas <kernel@kolivas.org>

agreed. This only affects a scheduler slowpath [setscheduler()].

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
