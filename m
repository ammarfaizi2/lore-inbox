Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263001AbUHJIyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263001AbUHJIyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 04:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263204AbUHJIw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 04:52:56 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7055 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263001AbUHJIwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 04:52:00 -0400
Date: Tue, 10 Aug 2004 10:30:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.8-rc3-mm2
Message-ID: <20040810083018.GA27270@elte.hu>
References: <20040808152936.1ce2eab8.akpm@osdl.org> <20040809112550.2ea19dbf.akpm@osdl.org> <200408091132.39752.jbarnes@engr.sgi.com> <200408091217.50786.jbarnes@engr.sgi.com> <20040809195323.GU11200@holomorphy.com> <20040809204357.GX11200@holomorphy.com> <20040809211042.GY11200@holomorphy.com> <20040809224546.GZ11200@holomorphy.com> <20040810063445.GE11200@holomorphy.com> <20040810080206.GF11200@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810080206.GF11200@holomorphy.com>
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


* William Lee Irwin III <wli@holomorphy.com> wrote:

> Okay, it's down to one printk() and other smaller changes now. The
> mb() and __init removal are both unnecessary too.

so the same patch but without the printk change still crashes?

how about applying only the printk change? (delay effect?)

	Ingo
