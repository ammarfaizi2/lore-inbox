Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVBHIpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVBHIpj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 03:45:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261490AbVBHIpj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 03:45:39 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45709 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261485AbVBHIpf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 03:45:35 -0500
Date: Tue, 8 Feb 2005 09:45:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.11-rc3-V0.7.38-01
Message-ID: <20050208084529.GD24669@elte.hu>
References: <20050204100347.GA13186@elte.hu> <200502080755.j187tFI8003915@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502080755.j187tFI8003915@turing-police.cc.vt.edu>
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


* Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:

> I found a CONFIG_NET_PKTGEN=Y in the config, rebuilt with =n, and the
> resulting kernel boots fine (am using it as I type). Vanilla -rc3-mm1
> also boots fine with the PTKGEN=y setting (as did
> 2.6.10-mm1-V0.7.34-01, the last -mm I built with a -RT patch).  I
> haven't tried a vanilla -rc3-V0.7.38-03, but I don't see anyplace -mm1
> hits pktgen.c
> 
> If the above isn't enough to track down the issue, feel free to let me
> know what you'd like me to try next.

i tried to enable NET_PKTGEN in my vanilla-based -RT tree and it
boots/works fine. Could you try a vanilla-based -RT tree too, with
NET_PKTGEN enabled, and if it breaks send me your .config - if it doesnt
break then could you send me your -mm1 .config?

	Ingo
