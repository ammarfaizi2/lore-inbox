Return-Path: <linux-kernel-owner+w=401wt.eu-S1422757AbWLUNat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422757AbWLUNat (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 08:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422881AbWLUNat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 08:30:49 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:35106 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422757AbWLUNas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 08:30:48 -0500
Date: Thu, 21 Dec 2006 14:27:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: Re: [PATCH -rt 1/4] ARM: Include compilation and warning fixes
Message-ID: <20061221132732.GA25861@elte.hu>
References: <458A4742.3060204@gmail.com> <20061221095239.GB1994@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061221095239.GB1994@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Thu, Dec 21, 2006 at 09:35:14AM +0100, Dirk Behme wrote:
> > 
> > ARM: Fix compilation issues and warnings for CONFIG PREEMPT
> > RT for ARM in include/asm-arm/system.h.
> > 
> > Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 
> Patches like this have been flying around for over a week now, but the 
> bug's been fixed using a different approach.  Unfortunately, Linus 
> hasn't pulled the fixes yet, presumably due to being engrossed in 
> fixing this data corruption issue.

update: it just into upstream -git to which i rebase daily, so i dropped 
the first patch and i'm relying on your fix now in -rt.

	Ingo
