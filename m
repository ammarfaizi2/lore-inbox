Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757554AbWK3GU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757554AbWK3GU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 01:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757639AbWK3GU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 01:20:58 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31395 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1757554AbWK3GU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 01:20:56 -0500
Date: Thu, 30 Nov 2006 07:19:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Wenji Wu <wenji@fnal.gov>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-ID: <20061130061912.GB2003@elte.hu>
References: <2f2083e145b6.456de740@fnal.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f2083e145b6.456de740@fnal.gov>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -4.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.5 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	1.4 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Wenji Wu <wenji@fnal.gov> wrote:

> > That yield() will need to be removed - yield()'s behaviour is truly 
> > awfulif the system is otherwise busy.  What is it there for?
> 
> Please read the uploaded paper, which has detailed description.

do you have any URL for that?

	Ingo
