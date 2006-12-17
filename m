Return-Path: <linux-kernel-owner+w=401wt.eu-S1752302AbWLQJa6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbWLQJa6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 04:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWLQJa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 04:30:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:59642 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752301AbWLQJa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 04:30:58 -0500
Date: Sun, 17 Dec 2006 10:28:28 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Message-ID: <20061217092828.GA14181@elte.hu>
References: <20061216153346.18200.51408.stgit@localhost.localdomain> <20061216165738.GA5165@elte.hu> <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com> <20061217085859.GB2938@elte.hu> <20061217090943.GA9246@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217090943.GA9246@elte.hu>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


one more thing: after bootup i need to access the /debug/memleak file 
twice to get any output from it - is that normal? The first 'cat 
/debug/memleak' gives no output (but there's the usual scanning delay, 
so memleak does do its work).

	Ingo
