Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266704AbUIEOEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266704AbUIEOEb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUIEOCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:02:07 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39579 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266737AbUIEOBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:01:16 -0400
Date: Sun, 5 Sep 2004 16:02:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>, "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel@vger.kernel.org, rlrevell@joe-job.com,
       felipe_alfaro@linuxmail.org
Subject: [patch] voluntary-preempt-2.6.9-rc1-bk12-R5
Message-ID: <20040905140249.GA23502@elte.hu>
References: <20040903120957.00665413@mango.fruits.de> <20040904195141.GA6208@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040904195141.GA6208@elte.hu>
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


i've released -R5:
 
  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc1-bk12-R5

2.6.9-rc1-bk12 patching order is:

   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/patch-2.6.9-rc1-bk12.bz2

Changes in -R5:

 - merge to 2.6.9-rc1-bk12

 - fixed an in_atomic() bug in the SMP && !PREEMPT kernel

	Ingo
