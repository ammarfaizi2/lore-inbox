Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbWF3HDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbWF3HDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 03:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbWF3HDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 03:03:46 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:64392 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932080AbWF3HDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 03:03:45 -0400
Date: Fri, 30 Jun 2006 08:59:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-mm3 -- BUG: illegal lock usage -- illegal {softirq-on-W} -> {in-softirq-R} usage.
Message-ID: <20060630065904.GA6856@elte.hu>
References: <a44ae5cd0606291201v659b4235sfa9941aa3b18e766@mail.gmail.com> <20060630065041.GB6572@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630065041.GB6572@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5002]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> hm, is this all the log output you got? In particular the printouts of 
> where various lock-class state changing events happened that are 
> important too. Could you send me the whole dmesg?

sorry, i take this back - the messages are complete.

	Ingo
