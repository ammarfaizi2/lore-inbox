Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266758AbUI1ADf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266758AbUI1ADf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 20:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUI1ADf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 20:03:35 -0400
Received: from scanner1.mail.elte.hu ([157.181.1.137]:433 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266758AbUI1ADd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 20:03:33 -0400
Date: Tue, 28 Sep 2004 02:05:16 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
Message-ID: <20040928000516.GA3096@elte.hu>
References: <1094683020.1362.219.camel@krustophenia.net> <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040924074416.GA17924@elte.hu>
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


i've released the -S7 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7

this iteration is mainly a merge to -mm4. (-mm4 includes PREEMPT_BKL so
the -VP patch got smaller again - at least until -mm carries it.) The
patch undoes some more experimental scheduler patches that -mm includes.

The patching order is:
  
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc2.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc2/2.6.9-rc2-mm4/2.6.9-rc2-mm4.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7

	Ingo
