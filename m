Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUJMGN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUJMGN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 02:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268470AbUJMGN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 02:13:59 -0400
Received: from mx2.elte.hu ([157.181.151.9]:34186 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268440AbUJMGN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 02:13:58 -0400
Date: Wed, 13 Oct 2004 08:15:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Wen-chien Jesse Sung <jesse@cola.voip.idv.tw>,
       Mark_H_Johnson@Raytheon.com, "K.R. Foley" <kr@cybsft.com>
Subject: [patch] VP-2.6.9-rc4-mm1-T9
Message-ID: <20041013061518.GA1083@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041012195424.GA3961@elte.hu>
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


i've uploaded the -T9 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T9

this is a bugfixes-only release that should fix the highmem-related
issues reported by K.R. Foley and Mark H. Johnson: 3 more locks had to
be converted to raw.

to create a -T9 tree from scratch the patching order is:
 
   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.8.tar.bz2
 + http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.9-rc4.bz2
 + http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/2.6.9-rc4-mm1.bz2
 + http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-T9

	Ingo
