Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161125AbWJDHtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161125AbWJDHtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 03:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161128AbWJDHty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 03:49:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45967 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161125AbWJDHtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 03:49:53 -0400
Date: Wed, 4 Oct 2006 09:41:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-ID: <20061004074142.GA29332@elte.hu>
References: <20061001225720.115967000@cruncher.tec.linutronix.de> <20061002210053.16e5d23c.akpm@osdl.org> <20061003084729.GA24961@elte.hu> <20061003103503.GA6350@elte.hu> <20061003203620.d85df9c6.akpm@osdl.org> <20061004064620.GA22364@elte.hu> <20061004003228.98ec3b39.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004003228.98ec3b39.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Yet initscripts take a long time (especially applying the ipfilter 
> firewall rues for some reason), and `startx' takes a long time, etc.  
> This kernel takes 112 seconds to boot to a login prompt - other 
> kernels take 56 seconds (interesting ratio..)

you are still using the non-hres config, correct? (so this is still 
collateral damage on vanilla kernel functionality)

	Ingo
