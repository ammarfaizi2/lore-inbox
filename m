Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWCMJJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWCMJJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 04:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWCMJJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 04:09:26 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:42655 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932379AbWCMJJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 04:09:26 -0500
Date: Mon, 13 Mar 2006 10:06:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Peter Williams <pwil3058@bigpond.net.au>, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH][2/4] sched: add discrete weighted cpu load function
Message-ID: <20060313090658.GB5780@elte.hu>
References: <200603131906.11739.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603131906.11739.kernel@kolivas.org>
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


* Con Kolivas <kernel@kolivas.org> wrote:

> +/* Used instead of source_load when we know the type == 0 */
> +unsigned long weighted_cpuload(const int cpu)
> +{
> +	return (cpu_rq(cpu)->raw_weighted_load);

no braces in return please. Looks good to me otherwise.

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
