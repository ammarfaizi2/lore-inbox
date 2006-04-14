Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWDNWNB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWDNWNB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 18:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030209AbWDNWNB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 18:13:01 -0400
Received: from mga03.intel.com ([143.182.124.21]:62293 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030205AbWDNWM7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 18:12:59 -0400
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23376465:sNHT22547504"
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23405735:sNHT18265023"
Message-Id: <4t16i2$ma94t@orsmga001.jf.intel.com>
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,121,1144047600"; 
   d="scan'208"; a="23405725:sNHT17212258"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Steven Rostedt'" <rostedt@goodmis.org>,
       "LKML" <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>
Cc: "Linus Torvalds" <torvalds@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Thomas Gleixner" <tglx@linutronix.de>, "Andi Kleen" <ak@suse.de>,
       "Martin Mares" <mj@atrey.karlin.mff.cuni.cz>, <bjornw@axis.com>,
       <schwidefsky@de.ibm.com>, <benedict.gaster@superh.com>,
       <lethal@linux-sh.org>, "Chris Zankel" <chris@zankel.net>,
       "Marc Gauthier" <marc@tensilica.com>, "Joe Taylor" <joe@tensilica.com>,
       "David Mosberger-Tang" <davidm@hpl.hp.com>, <rth@twiddle.net>,
       <spyro@f2s.com>, <starvik@axis.com>, "Luck, Tony" <tony.luck@intel.com>,
       <linux-ia64@vger.kernel.org>, <ralf@linux-mips.org>,
       <linux-mips@linux-mips.org>, <grundler@parisc-linux.org>,
       <parisc-linux@parisc-linux.org>, <linuxppc-dev@ozlabs.org>,
       <paulus@samba.org>, <linux390@de.ibm.com>, <lethal@linux-sh.org>,
       <davem@davemloft.net>, <chris@zankel.net>
Subject: RE: [PATCH 00/05] robust per_cpu allocation for modules
Date: Fri, 14 Apr 2006 15:12:52 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcZgCRaKo5LPRXFvTha4PDZxynOXogAByO9A
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-OriginalArrivalTime: 14 Apr 2006 22:12:54.0089 (UTC) FILETIME=[93BB0B90:01C66010]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote on Friday, April 14, 2006 2:19 PM
> So the current solution has two flaws:
> 1. not robust. If we someday add more modules that together take up
>    more than 14K, we need to manually update the PERCPU_ENOUGH_ROOM.
> 2. waste of memory.  We have 14K of memory wasted per CPU. Remember
>    a 64 processor machine would be wasting 896K of memory!

If someone who has the money to own a 64-process machine, 896K of memory
is pocket change ;-)

- Ken
