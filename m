Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268536AbUIXHmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268536AbUIXHmz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 03:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268535AbUIXHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 03:42:55 -0400
Received: from scanner2.mail.elte.hu ([157.181.151.9]:1005 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268536AbUIXHmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 03:42:52 -0400
Date: Fri, 24 Sep 2004 09:44:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] voluntary-preempt-2.6.9-rc2-mm3-S6
Message-ID: <20040924074416.GA17924@elte.hu>
References: <20040908082050.GA680@elte.hu> <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923211206.GA2366@elte.hu>
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


i've released the -S6 VP patch:

   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm3-S6

this iteration fixes the 'dropped tcp connections' problem reported and
fixed by K.R. Foley.

The patching order is:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
 + http://redhat.com/~mingo/voluntary-preempt/2.6.9-rc2-pre-mm3-mingo.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm3-S6
 
	Ingo
