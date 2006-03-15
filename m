Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWCOWhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWCOWhE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWCOWhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:37:04 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:43453 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1751468AbWCOWhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:37:01 -0500
Date: Wed, 15 Mar 2006 17:36:56 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Garzik <jeff@garzik.org>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost ticks on PM timer]
Message-ID: <20060315223656.GC17817@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Ingo Molnar <mingo@elte.hu>, Jeff Garzik <jeff@garzik.org>,
	Lee Revell <rlrevell@joe-job.com>, Andi Kleen <ak@suse.de>,
	Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
	john stultz <johnstul@us.ibm.com>
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu> <441893AB.1070300@garzik.org> <20060315222441.GA24074@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060315222441.GA24074@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2006 at 11:24:41PM +0100, Ingo Molnar wrote:
> well, it's a PIO inb() op i think, and could thus in theory trigger SMM 
> BIOS code.
 
Is there any easy way to disable more SMM stuff than "noacpi"?

If push comes to shove, I'll go all the way and just install LinuxBIOS
on the damn thing.  Though I'm sure that will be a chore.

	-Bill
