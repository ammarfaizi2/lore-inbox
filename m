Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVG0OgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVG0OgO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVG0Od6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:33:58 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56709 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262104AbVG0Odd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:33:33 -0400
Date: Wed, 27 Jul 2005 16:33:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050727143318.GA26303@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain> <20050727141754.GA25356@elte.hu> <1122474396.29823.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122474396.29823.65.camel@localhost.localdomain>
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

> Perfectly understood.  I've had two customers ask me to increase the 
> priorities for them, but those where custom kernels, and a config 
> option wasn't necessary. But since I've had customers asking, I 
> thought that this might be something that others want.  But I deal 
> with a niche market, and what my customers want might not be what 
> everyone wants. (hence the RFC in the subject).
> 
> So if there are others out there that would prefer to change their 
> priority ranges, speak now otherwise this patch will go by the waste 
> side.

i'm not excluding that this will become necessary in the future. We 
should also add the safety check to sched.h - all i'm suggesting is to 
not make it a .config option just now, because that tends to be fiddled 
with.

	Ingo
