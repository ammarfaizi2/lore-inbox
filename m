Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266243AbUHPEAP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUHPEAP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265102AbUHPEAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:00:15 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32414 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S267407AbUHPEAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:00:11 -0400
Date: Mon, 16 Aug 2004 06:01:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
Message-ID: <20040816040142.GA13531@elte.hu>
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

> I will try next with /dev/random disabled.  Don't most/many new
> machines have a hardware RNG that would eliminate the need for this
> code?

The C3 does have one IIRC, but do Intel CPUs have it too? Also, there's
the question of trust - how random it truly is. Is it a partly
pseudo-RNG masked via encryption? /dev/random i know is random, driven
by random timings of real disks and real network packets. The CPU's HRNG
is much more encapsulated and can only be blackbox-tested.

	Ingo
