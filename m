Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932886AbWFWG4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbWFWG4R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 02:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932887AbWFWG4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 02:56:17 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:39394 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932886AbWFWG4Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 02:56:16 -0400
Date: Fri, 23 Jun 2006 08:50:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com, johnstul@us.ibm.com,
       tytso@us.ibm.com, dvhltc@us.ibm.com
Subject: Re: [PATCH -rt] NUMA-Q fix to __cache_free and reap_alien
Message-ID: <20060623065035.GB28413@elte.hu>
References: <20060622233512.GA2792@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622233512.GA2792@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> The attached patch (no doubt quite crudely) fixes a couple of compiler 
> errors on NUMA-Q machines.  With these fixes, 2.6.17-rt1 builds, 
> boots, and runs kernelbench and LTP on NUMA-Q.

thanks, applied.

	Ingo
