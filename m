Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932810AbWF0KRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbWF0KRZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 06:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWF0KRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 06:17:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:20121 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932810AbWF0KRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 06:17:24 -0400
Date: Tue, 27 Jun 2006 12:12:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Robert Crocombe <rwcrocombe@raytheon.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: 2.6.17-rt1: Patch for NUMA mm/slab.c
Message-ID: <20060627101227.GB17160@elte.hu>
References: <449DF0FC.1050609@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449DF0FC.1050609@raytheon.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5060]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Robert Crocombe <rwcrocombe@raytheon.com> wrote:

> Needed to add this_cpu in a couple of places.  Compiled and no 
> problems so far...

thanks. I ended up applying Paul E. McKenney's patch which he sent 
shortly before you.

	Ingo
