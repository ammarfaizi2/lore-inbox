Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUHPES1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUHPES1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 00:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267414AbUHPES1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 00:18:27 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:27117 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267413AbUHPESZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 00:18:25 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P0
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040816030818.GA10685@elte.hu>
References: <20040810132654.GA28915@elte.hu>
	 <20040812235116.GA27838@elte.hu> <1092382825.3450.19.camel@mindpipe>
	 <20040813104817.GI8135@elte.hu> <1092432929.3450.78.camel@mindpipe>
	 <20040814072009.GA6535@elte.hu> <20040815115649.GA26259@elte.hu>
	 <20040816022554.16c3c84a@mango.fruits.de>
	 <1092622121.867.109.camel@krustophenia.net> <20040816024314.GA8960@elte.hu>
	 <20040816030818.GA10685@elte.hu>
Content-Type: text/plain
Message-Id: <1092629953.810.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 16 Aug 2004 00:19:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-15 at 23:08, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > just to check this theory, could you make __check_and_rekey() an empty
> > function? This should still produce a working random driver, albeit at
> > much reduced entropy. If these latencies have a relationship to the
> > mlockall() issue then this change should have an effect.
> 
> hm, could you disable the random driver in the .config rather? It seems
> that adding to the entropy pool (from hardirq context) alone is quite
> expensive too.
> 

Can this be disabled in the .config?  I can't find an option for it.

Lee

