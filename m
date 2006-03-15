Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751146AbWCOXb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbWCOXb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 18:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWCOXb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 18:31:29 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5597 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751146AbWCOXb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 18:31:29 -0500
Subject: Re: libata/sata_nv latency on NVIDIA CK804 [was Re: AMD64 X2 lost
	ticks on PM timer]
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@suse.de>,
       Jason Baron <jbaron@redhat.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <441899A0.8030608@garzik.org>
References: <200602280022.40769.darkray@ic3man.com>
	 <4408BEB5.7000407@garzik.org>
	 <20060303234330.GA14401@ti64.telemetry-investments.com>
	 <200603040107.27639.ak@suse.de>
	 <20060315213638.GA17817@ti64.telemetry-investments.com>
	 <1142459152.1671.64.camel@mindpipe> <20060315215848.GB18241@elte.hu>
	 <441893AB.1070300@garzik.org> <20060315222441.GA24074@elte.hu>
	 <20060315223656.GC17817@ti64.telemetry-investments.com>
	 <441899A0.8030608@garzik.org>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 18:31:25 -0500
Message-Id: <1142465486.1671.88.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-15 at 17:48 -0500, Jeff Garzik wrote:
> Bill Rugolsky Jr. wrote:
> > On Wed, Mar 15, 2006 at 11:24:41PM +0100, Ingo Molnar wrote:
> > 
> >>well, it's a PIO inb() op i think, and could thus in theory trigger SMM 
> >>BIOS code.
> > 
> >  
> > Is there any easy way to disable more SMM stuff than "noacpi"?
> 
> It's unlikely you can disable SMM stuff even with noacpi...

A while back someone posted some code from RTAI to disable a bunch of
SMM stuff, check the archives.  I sometimes wonder where the heck the
realtime people were when the SMM abomination was being developed...

Lee

