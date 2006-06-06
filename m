Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWFFTaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWFFTaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbWFFTaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:30:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:41707 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751001AbWFFTaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:30:18 -0400
Date: Tue, 6 Jun 2006 21:29:44 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andy Whitcroft <apw@shadowen.org>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, mbligh@google.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] better lock debugging: remove mutex deadlock checking code
Message-ID: <20060606192944.GB15882@elte.hu>
References: <44845C27.3000006@google.com> <20060605194422.GB14709@elte.hu> <20060605130039.db1ac80c.rdunlap@xenotime.net> <20060606085623.GA2932@elte.hu> <448569C9.9080401@shadowen.org> <4485B8C4.2070700@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4485B8C4.2070700@shadowen.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5186]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Whitcroft <apw@shadowen.org> wrote:

> > I'll shove this one in for testing too.  Results on TKO as I have them.
> 
> This is definatly clearing up a bunch of problems with the current 
> -mm.

great! Thanks for testing this out, this bug was the scariest pending 
one.

	Ingo
