Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162330AbWKQNcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162330AbWKQNcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162413AbWKQNcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:32:48 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:8072 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1162330AbWKQNcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:32:47 -0500
Date: Fri, 17 Nov 2006 14:31:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Wolfgang Erig <Wolfgang.Erig@fujitsu-siemens.com>,
       Andreas Friedrich <andreas.friedrich@fujitsu-siemens.com>,
       Adrian Bunk <bunk@stusta.de>, Greg Kroah-Hartman <gregkh@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] i386/x86_64: ACPI cpu_idle_wait() fix
Message-ID: <20061117133128.GA15404@elte.hu>
References: <20061116122820.GA2718@upset.pdb.fsc.net> <20061116123335.GA1392@elte.hu> <20061116124132.GA9048@upset.pdb.fsc.net> <20061116131842.GA12961@elte.hu> <20061116133019.GA14546@upset.pdb.fsc.net> <20061116144356.GA4891@elte.hu> <20061117090356.GA26013@upset.pdb.fsc.net> <20061117112237.GA26270@elte.hu> <20061117124913.GA24893@upset.pdb.fsc.net> <20061117132618.GA14411@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117132618.GA14411@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4716]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> The scheduler on Andreas Friedrich's hyperthreading system stopped 
> working properly as of 2.6.18: the scheduler would never move tasks to 
> another CPU!

correction: the last known working kernel was 2.6.8. The bug predates 
our GIT history so it's older than 1.5 years.

	Ingo
