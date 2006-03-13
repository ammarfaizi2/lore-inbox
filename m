Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWCMJOW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWCMJOW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWCMJOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:14:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:10153 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932378AbWCMJOV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:14:21 -0500
Date: Mon, 13 Mar 2006 10:11:54 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jan Altenberg <tb10alj@tglx.de>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH] 2.6.16-rc6-rt1: Fix redefinition and unknown symbol
Message-ID: <20060313091154.GD5780@elte.hu>
References: <20060312220218.GA3469@elte.hu> <441517B8.6030607@tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <441517B8.6030607@tglx.de>
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


* Jan Altenberg <tb10alj@tglx.de> wrote:

> Hi,
> 
> this patch should fix some simple issues with 2.6.16-rc6-rt1:
> 
> - Remove redefinition of rt_mutex_debug_check_no_locks_held
> - Add EXPORT_SYMBOL for rt_read_lock and rt_rw_unlock

thanks, applied.

	Ingo
