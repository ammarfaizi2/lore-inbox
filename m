Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266895AbUGVSC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266895AbUGVSC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266882AbUGVSBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:01:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37322 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266864AbUGVR7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 13:59:02 -0400
Date: Thu, 22 Jul 2004 20:00:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Rudo Thomas <rudo@matfyz.cz>
Subject: Re: voluntary-preempt I0: sluggish feel
Message-ID: <20040722180027.GB30059@elte.hu>
References: <1090389791.901.31.camel@mindpipe> <20040721082218.GA19013@elte.hu> <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722172428.GA5632@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rudo Thomas <rudo@matfyz.cz> wrote:

> OTOH, now the system feels terribly slow when voluntary_preemption is
> set to 2. Setting it to 0 or 1 makes the sluggish feel go away.

ok, i'm seeing this too - investigating. Must be something wrt. the
wakeup of ksoftirqd.

	Ingo
