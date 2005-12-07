Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbVLGJCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbVLGJCT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 04:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVLGJCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 04:02:19 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:53403 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750706AbVLGJCS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 04:02:18 -0500
Date: Wed, 7 Dec 2005 10:02:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Softirq preemption
Message-ID: <20051207090237.GA22918@elte.hu>
References: <1133464131.7898.30.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133464131.7898.30.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Lee Revell <rlrevell@joe-job.com> wrote:

> Is there any chance that the softirq preemption feature from the -rt 
> kernel can be pushed upstream?

yeah, will do it, once the current hrtimer push has been completed. The 
softirq/hardirq preemption feature is dependent on the genirq patch too.

	Ingo
