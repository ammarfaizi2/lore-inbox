Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267340AbUHDQHe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267340AbUHDQHe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267341AbUHDQFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:05:49 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:61140 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267340AbUHDQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:05:33 -0400
Date: Wed, 4 Aug 2004 18:05:29 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@redhat.com>
Cc: Shane Shrybman <shrybman@aei.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-O2
Message-ID: <20040804160528.GA9540@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@redhat.com>,
	Shane Shrybman <shrybman@aei.ca>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1091459297.2573.10.camel@mars> <Pine.LNX.4.58.0408031019090.20420@devserv.devel.redhat.com> <20040804112201.GA7842@ss1000.ms.mff.cuni.cz> <Pine.LNX.4.58.0408040754170.10810@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408040754170.10810@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I just wanted to report that O3 (+preempt-timing-O2) locks up hard at
> > random occasions, even with voluntary-preempt=2 preempt=1 set at boot
> > time. I never changed any of /proc/irq/*/threaded.
> 
> could you check whether it works with all APIC options turned off in the
> .config?

It appears to. With APIC on, it crashed after 10 and 25 minutes. Without APIC,
it survived two hours.

Hope that helps.

Rudo.
