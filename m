Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbVJKLRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbVJKLRU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 07:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbVJKLRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 07:17:20 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65500 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751457AbVJKLRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 07:17:19 -0400
Date: Tue, 11 Oct 2005 13:17:53 +0200
From: Ingo Molnar <mingo@elte.hu>
To: John Rigg <lk@sound-man.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt10 crashes on boot
Message-ID: <20051011111753.GA15937@elte.hu>
References: <E1EOe3U-00018A-Fy@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1EOe3U-00018A-Fy@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* John Rigg <lk@sound-man.co.uk> wrote:

> Ingo, thanks to help from Steve Rostedt I got 2.6.14-rc3-rt12 to 
> compile with CONFIG_DEBUG_STACKOVERFLOW=y on x86_64 smp. Unfortunately 
> if I enable it along with latency tracing (which is causing the crash 
> during boot) it crashes so early that I can't get anything from the 
> serial console, even using earlyprintk.

i fixed this in -rc4-rt1, could you give it a try?

	Ingo
