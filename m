Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752023AbWIXSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbWIXSHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752130AbWIXSHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 14:07:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:34258 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1752023AbWIXSHR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 14:07:17 -0400
Date: Sun, 24 Sep 2006 19:59:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Christian Weiske <cweiske@cweiske.de>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at virtual address 000,0000a
Message-ID: <20060924175934.GA15420@elte.hu>
References: <45155915.7080107@cweiske.de> <20060923134244.e7b73826.akpm@osdl.org> <45164BA6.60200@cweiske.de> <20060924031923.76886810.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924031923.76886810.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> You have tcp_v6 lockdep warnings.  They're in
> http://xml.cweiske.de/dojo%20kernelpanic%20+%20debug.tar.bz2 is anyone is
> keen.  (I've largely lost interest in lockdep warnings - many of them are
> false positives and require make-lockdep-shut-up patches).

FYI, this is from Herbert Xu's recent mail to netdev:

| Subject: Re: neigh_lookup lockdep warning
|
| [...]
| BTW, out of the last four validator reports I've read three have 
| turned out to be genuine bugs.  So you guys have done a fantastic job!
