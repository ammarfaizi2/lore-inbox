Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751957AbWCOWsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbWCOWsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 17:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbWCOWsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 17:48:08 -0500
Received: from mail.dvmed.net ([216.237.124.58]:43147 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751957AbWCOWsH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 17:48:07 -0500
Message-ID: <441899A0.8030608@garzik.org>
Date: Wed, 15 Mar 2006 17:48:00 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
CC: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       Andi Kleen <ak@suse.de>, Jason Baron <jbaron@redhat.com>,
       linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
 ticks on PM timer]
References: <200602280022.40769.darkray@ic3man.com> <4408BEB5.7000407@garzik.org> <20060303234330.GA14401@ti64.telemetry-investments.com> <200603040107.27639.ak@suse.de> <20060315213638.GA17817@ti64.telemetry-investments.com> <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu> <441893AB.1070300@garzik.org> <20060315222441.GA24074@elte.hu> <20060315223656.GC17817@ti64.telemetry-investments.com>
In-Reply-To: <20060315223656.GC17817@ti64.telemetry-investments.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Rugolsky Jr. wrote:
> On Wed, Mar 15, 2006 at 11:24:41PM +0100, Ingo Molnar wrote:
> 
>>well, it's a PIO inb() op i think, and could thus in theory trigger SMM 
>>BIOS code.
> 
>  
> Is there any easy way to disable more SMM stuff than "noacpi"?

It's unlikely you can disable SMM stuff even with noacpi...

	Jeff



