Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWCOXoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWCOXoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752179AbWCOXoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:44:06 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:52958 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751053AbWCOXoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:44:05 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Lee Revell <rlrevell@joe-job.com>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
In-Reply-To: <20060315231426.GD17817@ti64.telemetry-investments.com>
References: <200602280022.40769.darkray@ic3man.com>
	 <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu>
	 <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu>
	 <44189A3D.5090202@garzik.org>
	 <20060315231426.GD17817@ti64.telemetry-investments.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 18:44:02 -0500
Message-Id: <1142466242.1671.96.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 18:14 -0500, Bill Rugolsky Jr. wrote:
> [Meanwhile, I still have to switch contexts and look at the long
> softirq latencies that at first glance appear to be due to the use of
> mempool by the RAID1 bio code.] 

Can you post traces of them somewhere?  There are no long running
softirqs in the two you posted (the worst is only 200 usecs or so).

Lee

