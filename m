Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261593AbVCaRxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261593AbVCaRxG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 12:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVCaRxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 12:53:06 -0500
Received: from mx1.elte.hu ([157.181.1.137]:53481 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261593AbVCaRxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 12:53:04 -0500
Date: Thu, 31 Mar 2005 19:49:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050331174927.GA11483@elte.hu>
References: <Pine.OSF.4.05.10503302042450.2022-100000@da410.phys.au.dk> <1112212608.3691.147.camel@localhost.localdomain> <1112218750.3691.165.camel@localhost.localdomain> <20050331110330.GA24842@elte.hu> <1112273378.3691.228.camel@localhost.localdomain> <20050331141040.GA2544@elte.hu> <1112290916.12543.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112290916.12543.19.camel@localhost.localdomain>
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


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Oh, and did your really want to assign debug = .1?

> -	.debug = .1, .file = __FILE__, .line = __LINE__
> +	.debug = 1, .file = __FILE__, .line = __LINE__

doh - indeed. This means rwlocks were nondebug all along? Ouch. I've 
uploaded -42-08 with the fix.

	Ingo
