Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272644AbTHELFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 07:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272650AbTHELFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 07:05:52 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:26270
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272644AbTHELFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 07:05:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: arjanv@redhat.com
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 21:10:29 +1000
User-Agent: KMail/1.5.3
Cc: Nick Piggin <piggin@cyberone.com.au>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <200308050207.18096.kernel@kolivas.org> <200308052045.39476.kernel@kolivas.org> <1060080867.5308.2.camel@laptop.fenrus.com>
In-Reply-To: <1060080867.5308.2.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308052110.29435.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 20:54, Arjan van de Ven wrote:
> generally that's a sign that the approach might not be the best one.
>
> Lets face it: we're trying to estimate behavior here. Result: There
> ALWAYS will be mistakes in that estimator. The more complex the
> estimator the fewer such cases you will have, but the more mis-estimated
> such cases will be.
> The only way to really deal with estimators is to *ALSO* make the price
> you pay on mis-estimation acceptable. For the scheduler that most likely
> means that you can't punish as hard as we do now, nor give bonuses as
> much as we do now.

It is acceptable. This thread is getting carried away. Just because we 
continued talking doesn't mean there is suddenly a big problem. There is no 
sudden drop in performance or handling. It's a tiny tweak which helps and 
there is no evidence of harm, only a theoretical concern on Nick's part which 
ended up being a discussion about the merits of sleep_avg as a method of 
determining interactivity. Yes there probably is a better way of doing it 
(and I have embarked on one that I stopped doing), but a redesign from 
scratch now is not what Ingo wants, and I see the logic in his reasoning.

Con

