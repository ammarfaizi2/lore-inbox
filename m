Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbUKDVFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUKDVFv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbUKDVFE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:05:04 -0500
Received: from mx2.elte.hu ([157.181.151.9]:49893 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262370AbUKDTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:38:27 -0500
Date: Thu, 4 Nov 2004 20:38:19 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Michael J. Cohen" <mjc@unre.st>
Cc: sboyce@blueyonder.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
Message-ID: <20041104193819.GB10107@elte.hu>
References: <20041104100634.GA29785@elte.hu> <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost> <20041104114545.GA3722@elte.hu> <1099573171.7876.0.camel@optie.uni.325i.org> <1099575262.8110.1.camel@optie.uni.325i.org> <20041104140528.GA16604@elte.hu> <1099577631.8090.4.camel@optie.uni.325i.org> <20041104142317.GA19476@elte.hu> <1099593117.7982.14.camel@optie.uni.325i.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099593117.7982.14.camel@optie.uni.325i.org>
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


* Michael J. Cohen <mjc@unre.st> wrote:

> threw in your tcp_window oneliner mentioned in another thread and that
> seemed to curb the lockups I was getting.  xmms+jackd in realtime mode
> is getting some xruns during any kind of IDE activity. network isn't
> quite as fussy.

hm, have you chrt-ed the soundcard IRQ to a fifo priority higher than
50?

	Ingo
