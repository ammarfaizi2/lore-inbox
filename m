Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266191AbUGJI2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266191AbUGJI2s (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 04:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUGJI2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 04:28:48 -0400
Received: from mx1.elte.hu ([157.181.1.137]:31649 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S266191AbUGJI2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 04:28:46 -0400
Date: Sat, 10 Jul 2004 10:28:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: ismail =?iso-8859-1?Q?d=F6nmez?= <ismail.donmez@gmail.com>
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [announce] [patch] Voluntary Kernel Preemption Patch
Message-ID: <20040710082846.GA29275@elte.hu>
References: <20040709182638.GA11310@elte.hu> <20040709195105.GA4807@infradead.org> <20040709235017.GP20947@dualathlon.random> <20040710075747.GA25052@elte.hu> <2a4f155d040710011041a95210@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a4f155d040710011041a95210@mail.gmail.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* ismail dönmez <ismail.donmez@gmail.com> wrote:

> A patch against 2.6.7 would be more appreciated as Linus looks like
> won't release 2.6.8 soon.

i've uploaded the -H3 patch against 2.6.7-vanilla to:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.7-vanilla-H3

(NOTE: this patch upgrades to Jens' latest version of cfq-iosched.c,
because one of the might_sleep() additions uncovered a bug there.)

i've done a quick testboot on x86, seems to work fine.

	Ingo
