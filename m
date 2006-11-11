Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424023AbWKKPka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424023AbWKKPka (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 10:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424024AbWKKPka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 10:40:30 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50848 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1424023AbWKKPk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 10:40:29 -0500
Date: Sat, 11 Nov 2006 16:39:48 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ashok.raj@intel.com
Subject: Re: [patch] genapic: optimize & fix APIC mode setup
Message-ID: <20061111153948.GA5546@elte.hu>
References: <20061111151414.GA32507@elte.hu> <200611111620.24551.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611111620.24551.ak@suse.de>
User-Agent: Mutt/1.4.2.2i
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


* Andi Kleen <ak@suse.de> wrote:

> This will open a race on CPU hotunplug unfortunately
> (common for multi core suspend) 

how can i reproduce this btw, any instructions/pointers for that?

	Ingo
