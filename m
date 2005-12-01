Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVLASEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVLASEP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 13:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVLASEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 13:04:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52447 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932381AbVLASEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 13:04:14 -0500
Date: Thu, 1 Dec 2005 19:03:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andi Kleen <ak@suse.de>
cc: "Dugger, Donald D" <donald.d.dugger@intel.com>,
       linux-kernel@vger.kernel.org, "Shah, Rajesh" <rajesh.shah@intel.com>,
       akpm@osdl.org
Subject: Re: Add VT flag to cpuinfo; SSE3 flag
In-Reply-To: <20051201174901.GL19515@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0512011901310.437@yvahk01.tjqt.qr>
References: <7F740D512C7C1046AB53446D372001730615842C@scsmsx402.amr.corp.intel.com>
 <Pine.LNX.4.61.0512011837470.28511@yvahk01.tjqt.qr> <20051201174901.GL19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Oh BTW, I am missing an 'sse3' flag in /proc/cpuinfo on Opterons (running 
>> 2.6.13). Could this be added, if it has not yet in 2.6.15rc*?
>
>It's pni for historical reasons.

I could not find pni either. This is all what cpuinfo gives on one:

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 15
model           : 5
model name      : AMD Opteron(tm) Processor 248
stepping        : 10
cpu MHz         : 2190.310
cache size      : 1024 KB
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 
3dnow
bogomips        : 4374.52
TLB size        : 1088 4K pages
clflush size    : 64
cache_alignment : 64
address sizes   : 40 bits physical, 48 bits virtual
power management: ts fid vid ttp



Jan Engelhardt
-- 
