Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUIJMks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUIJMks (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUIJMks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:40:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:46527 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265230AbUIJMkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:40:46 -0400
Date: Fri, 10 Sep 2004 14:42:03 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Eric St-Laurent <ericstl34@sympatico.ca>, Free Ekanayaka <free@agnula.org>,
       free78@tin.it, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>, luke@audioslack.com,
       nando@ccrma.stanford.edu,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       Daniel Schmitt <pnambic@unu.nu>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040910124203.GA6864@elte.hu>
References: <OFCD36C23F.77F7902E-ON86256F0A.007DDE1A@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFCD36C23F.77F7902E-ON86256F0A.007DDE1A@raytheon.com>
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


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> >I tried
> >  hdparm -p -X udma2 /dev/hda
> >(since it was udma4 previously)
> >and reran the tests.
> Not quite sure this was what I wanted - appears to turn on PIO modes
> exclusively.
>
> What is the right incantation for this?

does 'hdparm -X udma2 /dev/hda' work? -p seems to be some PIO auto-tune 
option that you probably dont need.

	Ingo
