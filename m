Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVG0S7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVG0S7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVG0S6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:58:11 -0400
Received: from mx2.elte.hu ([157.181.151.9]:46233 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262486AbVG0Swx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:52:53 -0400
Date: Wed, 27 Jul 2005 20:52:34 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] safty check of MAX_RT_PRIO >= MAX_USER_RT_PRIO
Message-ID: <20050727185234.GA1699@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain> <20050727141754.GA25356@elte.hu> <1122474396.29823.65.camel@localhost.localdomain> <20050727143318.GA26303@elte.hu> <1122475620.29823.77.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122475620.29823.77.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 2005-07-27 at 16:33 +0200, Ingo Molnar wrote:
> > i'm not excluding that this will become necessary in the future. We 
> > should also add the safety check to sched.h - all i'm suggesting is to 
> > not make it a .config option just now, because that tends to be fiddled 
> > with.
> 
> So Ingo, would you agree that at least this patch should go in?

yeah.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
