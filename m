Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267409AbUHPEE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267409AbUHPEE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267407AbUHPEE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:04:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:6563 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267409AbUHPEER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:04:17 -0400
Date: Mon, 16 Aug 2004 06:05:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: [patch] voluntary-preempt-2.6.8.1-P1
Message-ID: <20040816040515.GA13665@elte.hu>
References: <20040815115649.GA26259@elte.hu> <20040816022554.16c3c84a@mango.fruits.de> <1092622121.867.109.camel@krustophenia.net> <20040816023655.GA8746@elte.hu> <1092624221.867.118.camel@krustophenia.net> <20040816032806.GA11750@elte.hu> <20040816033623.GA12157@elte.hu> <1092627691.867.150.camel@krustophenia.net> <20040816034618.GA13063@elte.hu> <1092628493.810.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092628493.810.3.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Anyway, the change to sched.c fixes the mlockall bug, it works
> perfectly now.  Thanks!

great! This fix also means that we've got one more lock-break in the
ext3 journalling code and one more lock-break in dcache.c. I've released
-P1 with the fix included:

 http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P1

	Ingo
