Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269292AbUICHk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269292AbUICHk5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 03:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269298AbUICHk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 03:40:57 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:11185 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269292AbUICHkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 03:40:33 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <20040903070500.GB13100@elte.hu>
References: <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu>
	 <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
	 <1094194157.19760.71.camel@krustophenia.net>
	 <20040903070500.GB13100@elte.hu>
Content-Type: text/plain
Message-Id: <1094197233.19760.115.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 03:40:34 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 03:05, Ingo Molnar wrote:
> another question - any objections against me rebasing the VP patch to
> the current -mm tree and keeping it there exclusively until all possible
> merges are done? It would probably quite some work to create a complete
> patch for the upstream or BK tree during that process, as small patches
> start to flow in the VP => -mm => BK direction. Would any of the regular
> VP users/testers be wary to use the -mm tree?
> 

None here.  Assuming the SMP issues are resolved, then the only
remaining issues on UP will probably be with various drivers, those
fixes should apply just as easily to -mm as vanilla.

As far as I am concerned the VP patches are stable enough for the
audio-centric distros to start distributing VP kernel packages, these
will certainly be using the vanilla kernel.  I think the PlanetCCRMA and
AGNULA people are planning to start distributing test VP-kernel packages
as soon as the patches stabilize.  IIRC Nando is on vacation this week.

I will make an announcement on LAD that as of R0 the VP patches should
be stable and are ready for wider testing.  You may want to wait until
after the initial slew of bug reports before rebasing VP against MM.  I
suspect most of the problems with be driver specific, and most of the
fixes will apply equally to -mm and vanilla.

I have added Luke (AudioSlack), Free (AGNULA), and Nando (CCRMA) to the
cc: list.  They would be in the best position to answer your question.

Lee


