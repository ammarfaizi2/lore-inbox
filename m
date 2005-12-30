Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVL3NH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVL3NH2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 08:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbVL3NH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 08:07:28 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39931 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751255AbVL3NH1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 08:07:27 -0500
Subject: Re: Latency traces I cannot interpret (sa1100, 2.6.15-rc7-rt1)
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, kus Kusche Klaus <kus@keba.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051230074424.GB25637@elte.hu>
References: <AAD6DA242BC63C488511C611BD51F367323307@MAILIT.keba.co.at>
	 <1135927789.12146.1.camel@mindpipe>  <20051230074424.GB25637@elte.hu>
Content-Type: text/plain
Date: Fri, 30 Dec 2005 05:07:25 -0800
Message-Id: <1135948046.32431.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-30 at 08:44 +0100, Ingo Molnar wrote:
> there seem to be leaked preempt counts:
> 
>   <idle>-0     0.n.1 8974us : touch_critical_timing (cpu_idle)
> 
> we should never have preemption disabled in cpu_idle(). To debug leaked 
> preemption counts, enable CONFIG_DEBUG_PREEMPT.

ARM does disable preemption in cpu_idle() . 

Daniel

