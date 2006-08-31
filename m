Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbWHaQoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbWHaQoD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932380AbWHaQn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:43:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45521 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932377AbWHaQn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:43:58 -0400
Date: Thu, 31 Aug 2006 18:36:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "akpm@osdl.org" <akpm@osdl.org>, ak@muc.de,
       pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Subject: Re: - i386-early-fault-handler.patch removed from -mm tree
Message-ID: <20060831163605.GA18039@elte.hu>
References: <200608311221_MC3-1-C9EE-3549@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608311221_MC3-1-C9EE-3549@compuserve.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4999]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Chuck Ebbert <76306.1226@compuserve.com> wrote:

> > This patch was dropped because a different version got merged by andi
> 
> <*sigh*>
> 
> Didn't anyone even notice the fix that was already in -mm?  Now we're 
> back to "guess which fault it was" when an early fault occurs.

just revert Andi's and apply your patch, and send the resulting combo 
patch to Andrew.

	Ingo
