Return-Path: <linux-kernel-owner+w=401wt.eu-S1755392AbXABRJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755392AbXABRJ4 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755390AbXABRJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:09:56 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:33068 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755392AbXABRJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:09:55 -0500
Date: Tue, 2 Jan 2007 18:06:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: add missing debug_check_no_locks_freed for kmem_cache_free
Message-ID: <20070102170627.GC25271@elte.hu>
References: <Pine.LNX.4.64.0701021838230.24781@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701021838230.24781@sbz-30.cs.Helsinki.FI>
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


* Pekka J Enberg <penberg@cs.helsinki.fi> wrote:

> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> Add a missing debug_check_no_locks_freed() debug check for 
> kmem_cache_free().

hm, i have a similar fix in -rt already, and i sent a patch for this:

 http://lkml.org/lkml/2006/12/18/104

have i missed some API variant?

	Ingo
