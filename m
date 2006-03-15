Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752151AbWCOXO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbWCOXO2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752156AbWCOXO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:14:28 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:22207 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1752151AbWCOXO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:14:27 -0500
Date: Wed, 15 Mar 2006 18:14:26 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Lee Revell <rlrevell@joe-job.com>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315231426.GD17817@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Jeff Garzik <jeff@garzik.org>, Ingo Molnar <mingo@elte.hu>,
	Andi Kleen <ak@suse.de>, Lee Revell <rlrevell@joe-job.com>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <20060315215020.GA18241@elte.hu> <20060315221119.GA21775@elte.hu> <44189654.2080607@garzik.org> <20060315224408.GC24074@elte.hu> <44189A3D.5090202@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44189A3D.5090202@garzik.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 05:50:37PM -0500, Jeff Garzik wrote:
> Alas, it is far from that simple :(
> 
> The code I linked to isn't in a working state.  NV contributed it 
> largely as "it worked at one time" documentation of a 
> previously-undocumented register interface.
> 
> Someone needs to debug it.

Errrr, guess that would me me.  Looks like a few interfaces have changed.
I'll put some time in to see whether I can get it to compile and boot.
If it's just a sata_nv issue, the easier solution is to buy a 3ware or
Areca card ... but I'll take a shot at anyway.

[Meanwhile, I still have to switch contexts and look at the long softirq
latencies that at first glance appear to be due to the use of mempool
by the RAID1 bio code.]

	-Bill


