Return-Path: <linux-kernel-owner+willy=40w.ods.org-S449449AbUKBHxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S449449AbUKBHxE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 02:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S449439AbUKBHxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 02:53:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:45292 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S380442AbUKBHwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 02:52:49 -0500
Date: Tue, 2 Nov 2004 08:51:36 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kumar Gala <kumar.gala@freescale.com>, akpm@osdl.org,
       Christoph Hellwig <hch@infradead.org>,
       Pantelis Antoniou <panto@intracom.gr>,
       Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       "Gala Kumar K.-galak" <kumar.gala@motorola.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix early request_irq
Message-ID: <20041102075136.GA21077@elte.hu>
References: <20041029161101.GS2097@smtp.west.cox.net> <Pine.GSO.4.44.0411011140100.17740-100000@sysperf.somerset.sps.mot.com> <20041101195911.GL24459@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041101195911.GL24459@smtp.west.cox.net>
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


* Tom Rini <trini@kernel.crashing.org> wrote:

> On Mon, Nov 01, 2004 at 11:41:44AM -0600, Kumar Gala wrote:
> 
> > Andrew,
> > 
> > Please apply this patch from Tom Rini.  I've tested it for PowerPC MPC85xx
> > parts and it works.
> > 
> > Signed-off-by: Kumar Gala <kumar.gala@freescale.com>
> 
> I've attached a slightly different version, which applies against
> current -bk (Linus applied a patch from Ben that fixed pmac booting
> which made my patch not apply), which is the only change.
> 
> Signed-off-by: Tom Rini <trini@kernel.crashing.org>

thanks, this one looks so much cleaner than the early-kmalloc hack.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
