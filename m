Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUJQRlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUJQRlt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269239AbUJQRka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:40:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:57241 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S269237AbUJQRji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:39:38 -0400
Date: Sun, 17 Oct 2004 19:40:43 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041017174043.GA28906@elte.hu>
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <20041016153344.GA16766@elte.hu> <20041017190330.7a226190@mango.fruits.de> <20041017165509.GA26791@elte.hu> <20041017195358.4e473893@mango.fruits.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041017195358.4e473893@mango.fruits.de>
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


* Florian Schmidt <mista.tapas@gmx.net> wrote:

> > ok, does the patch below fix those messages? (gameport.c used its own,
> > private, incompatible prototype for i8253_lock which breaks raw spinlock
> > handling.)
> > 
> 
> it seems to fix it. i don't see any more messages like the reported
> anymore.

good!

> snd-cs46xx might have some other issues though: Upon rmmod snd-cs46xx
> i see:
> 
> Oct 17 19:43:04 mango kernel: Sound Fusion CS46xx 0000:00:0f.0: Device
> was removed without properly calling pci_disable_device(). This may
> need fixing.
> 
> but i should probably report that to alsa-devel instead right?

yeah, i think so.

	Ingo
