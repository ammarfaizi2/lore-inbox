Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbVHWGOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVHWGOg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 02:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbVHWGOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 02:14:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:44770 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S1750754AbVHWGOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 02:14:35 -0400
Date: Tue, 23 Aug 2005 08:14:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Peter Bortas <peter@bortas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-rt8
Message-ID: <20050823061445.GA30817@elte.hu>
References: <20050816121843.GA24308@elte.hu> <761x4s2uzg.fsf@bortas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <761x4s2uzg.fsf@bortas.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Bortas <peter@bortas.org> wrote:

> 2.6.13-rc6-rt8 fails to build with my configuration (attached):
> 
> net/built-in.o: In function `ip_rt_init':
> : undefined reference to `__you_cannot_kmalloc_that_much'
> make[1]: *** [.tmp_vmlinux1] Error 1
> make[1]: Leaving directory `/usr/src/linux-2.6.13-rc6'
> make: *** [stamp-build] Error 2

ok, fixed the likely cause of this in -rt12. Could you check whether it 
builds for you now?

	Ingo
