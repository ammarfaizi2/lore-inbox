Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbVJHL5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbVJHL5x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 07:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJHL5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 07:57:53 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40846 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750771AbVJHL5x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 07:57:53 -0400
Date: Sat, 8 Oct 2005 13:58:28 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
Message-ID: <20051008115828.GA29042@elte.hu>
References: <1128724690.17981.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1128724690.17981.57.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Something appears to have disabled IRQs for 657 usecs.

hm ... i fixed one such bug in rt.c recently, but more could be lurking.  
Could you send me your .config?

	Ingo
