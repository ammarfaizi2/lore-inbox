Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267689AbUIFLFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267689AbUIFLFK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 07:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUIFLFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 07:05:10 -0400
Received: from mx2.elte.hu ([157.181.151.9]:940 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267689AbUIFLFE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 07:05:04 -0400
Date: Mon, 6 Sep 2004 13:06:26 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: rlrevell@joe-job.com, felipe_alfaro@linuxmail.org,
       Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>,
       Mark_H_Johnson@Raytheon.com
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk12-R6
Message-ID: <20040906110626.GA32320@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu> <20040905140249.GA23502@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040905140249.GA23502@elte.hu>
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


i've released the -R6 patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R6

Changes in -R6:

 - fixed a CONFIG_SMP + CONFIG_PREEMPT bug that had the potential to
   cause spinlock related lockups. (UP kernels are unaffected.) This bug 
   got introduced in -R5.

2.6.9-rc1-bk12 patching order is:
 
    http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
  + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
  + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2
 
	Ingo
