Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265518AbTFSS42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 14:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbTFSS42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 14:56:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:962 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S265518AbTFSS41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 14:56:27 -0400
Date: Thu, 19 Jun 2003 21:09:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Robert Love <rml@tech9.net>
Cc: Joe Korty <joe.korty@ccur.com>, george anzinger <george@mvista.com>,
       "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Andrew Morton'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "Li, Adam" <adam.li@intel.com>
Subject: Re: [patch] setscheduler fix
In-Reply-To: <1056044732.8770.39.camel@localhost>
Message-ID: <Pine.LNX.4.44.0306192102090.19984-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 19 Jun 2003, Robert Love wrote:

> +		if (rq->curr == p) {
> +			if (p->prio > oldprio)
> +				resched_task(rq->curr);
> +		} else if (p->prio < rq->curr->prio)
> +			resched_task(rq->curr);
> +	}

looks good.

	Ingo

