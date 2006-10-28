Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751333AbWJ1SWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbWJ1SWJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 14:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbWJ1SWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 14:22:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:48805 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751333AbWJ1SWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 14:22:08 -0400
Subject: Re: AMD X2 unsynced TSC fix?
From: Lee Revell <rlrevell@joe-job.com>
To: Andi Kleen <ak@suse.de>
Cc: thockin@hockin.org, vojtech@suse.cz, Jiri Bohac <jbohac@suse.cz>,
       Luca Tettamanti <kronos.it@gmail.com>, linux-kernel@vger.kernel.org,
       john stultz <johnstul@us.ibm.com>
In-Reply-To: <200610272059.13753.ak@suse.de>
References: <1161969308.27225.120.camel@mindpipe>
	 <68676e00610271700i741b949frc73bf790d38ab1f@mail.gmail.com>
	 <20061028024638.GA16579@hockin.org>  <200610272059.13753.ak@suse.de>
Content-Type: text/plain
Date: Sat, 28 Oct 2006 14:22:11 -0400
Message-Id: <1162059732.14733.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-10-27 at 20:59 -0700, Andi Kleen wrote:
> > Fortunately, we usually have an HPET, these days.  You can
> definitely
> > resync and get near-linear values of RDTSC.
> 
> No we don't -- most BIOS still don't give us the HPET table 
> even when it is there in hardware. In the future this will change sure
> but people will still run a lot of older motherboards. 

I have exactly such a system (see thread "x86-64 with nvidia MCP51
chipset: kernel does not find HPET").  Is there anything at all I can do
to make the kernel see the HPET?  Can I try to guess the address?  BIOS
upgrade?

Lee

