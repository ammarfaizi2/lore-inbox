Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVDANAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVDANAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 08:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVDANAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 08:00:36 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50126 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262735AbVDAM6m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 07:58:42 -0500
Date: Fri, 1 Apr 2005 14:58:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Christoph Lameter <christoph@lameter.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] timers fixes/improvements
Message-ID: <20050401125827.GA3444@elte.hu>
References: <424D373F.1BCBF2AC@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424D373F.1BCBF2AC@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Oleg Nesterov <oleg@tv-sign.ru> wrote:

> This patch replaces and updates 6 timer patches which are currently in 
> -mm tree. This version does not play games with __TIMER_PENDING bit, 
> so incremental patch is not suitable. It is against 2.6.12-rc1. Please 
> comment. I am sending pseudo code in a separate message for easier 
> review.

i like it. This is nice too:

 2 files changed, 152 insertions(+), 193 deletions(-)

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
