Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWFFIdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWFFIdi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 04:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbWFFIdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 04:33:38 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:47318 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751173AbWFFIdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 04:33:37 -0400
Date: Tue, 6 Jun 2006 10:33:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc5-mm3-lockdep - locking error in quotaon
Message-ID: <20060606083304.GA2773@elte.hu>
References: <200606051700.k55H015q004029@turing-police.cc.vt.edu> <1149528339.3111.114.camel@laptopd505.fenrus.org> <200606051920.k55JKQGx003031@turing-police.cc.vt.edu> <20060605193552.GB24342@atrey.karlin.mff.cuni.cz> <1149537156.3111.123.camel@laptopd505.fenrus.org> <20060605200652.GC24342@atrey.karlin.mff.cuni.cz> <1149539183.3111.126.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149539183.3111.126.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Arjan van de Ven <arjan@linux.intel.com> wrote:

> ok since you know this doesn't deadlock the patch below (concept; akpm 
> please don't apply yet) ought to describe this special locking 
> situation to lockdep; I would really appreciate someone who does use 
> quota to test this out and see if it works....

looks good to me and doesnt produce messages on my system either.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
