Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752027AbWJaDDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027AbWJaDDd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752036AbWJaDDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:03:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:2638 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1752027AbWJaDDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:03:31 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,372,1157353200"; 
   d="scan'208"; a="153290032:sNHT22816584"
Date: Mon, 30 Oct 2006 18:41:55 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Chris Friesen <cfriesen@nortel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>, suresh.b.siddha@intel.com
Subject: Re: AMD X2 unsynced TSC fix?
Message-ID: <20061030184155.A3790@unix-os.sc.intel.com>
References: <1161969308.27225.120.camel@mindpipe> <1162009373.26022.22.camel@localhost.localdomain> <1162177848.2914.13.camel@localhost.portugal> <200610301623.14535.ak@suse.de> <1162253008.2999.9.camel@localhost.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1162253008.2999.9.camel@localhost.portugal>; from sergio@sergiomb.no-ip.org on Tue, Oct 31, 2006 at 12:03:28AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 12:03:28AM +0000, Sergio Monteiro Basto wrote:
> time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)
> time.c: Lost 300 timer tick(s)! rip mwait_idle+0x33/0x4f)

Is this the reason why you are saying your system has unsynchronized TSC?
Some where in this thread, you mentioned that Lost ticks happen even
when you use  "notsc"

This sounds to me as a different problem. Can you send us the output
of /proc/interrupts?

thanks,
suresh
