Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUHDLzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUHDLzt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 07:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUHDLzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 07:55:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1479 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264479AbUHDLzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 07:55:47 -0400
Date: Wed, 4 Aug 2004 07:54:51 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rudo Thomas <rudo@matfyz.cz>
cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
In-Reply-To: <20040804112201.GA7842@ss1000.ms.mff.cuni.cz>
Message-ID: <Pine.LNX.4.58.0408040754170.10810@devserv.devel.redhat.com>
References: <1091459297.2573.10.camel@mars> <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com>
 <20040804112201.GA7842@ss1000.ms.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Aug 2004, Rudo Thomas wrote:

> > thx - i fixed this in -O3.
> 
> Hi, Ingo.
> 
> I just wanted to report that O3 (+preempt-timing-O2) locks up hard at
> random occasions, even with voluntary-preempt=2 preempt=1 set at boot
> time. I never changed any of /proc/irq/*/threaded.
> 
> I will provide any information needed to hunt this down.

could you check whether it works with all APIC options turned off in the
.config?

	Ingo
