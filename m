Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWDHLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWDHLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 07:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWDHLz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 07:55:29 -0400
Received: from S0106001217d33fa6.vc.shawcable.net ([24.85.128.184]:33946 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S1750763AbWDHLz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 07:55:29 -0400
Date: Sat, 8 Apr 2006 04:55:32 -0700 (PDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: jensmh@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16.1 lost cpu, was: 2.6.16-rc5 'lost' cpu
In-Reply-To: <20060407132206.A27131@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0604080453290.10553@montezuma.fsmlabs.com>
References: <Pine.LNX.4.64.0603030954230.28074@montezuma.fsmlabs.com>
 <20060303103002.A26876@unix-os.sc.intel.com> <200604071845.38371.jensmh@gmx.de>
 <20060407132206.A27131@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2006, Ashok Raj wrote:

> On Fri, Apr 07, 2006 at 06:45:36PM +0200, jensmh@gmx.de wrote:
> 
> Oh well, seems like that CPU has trouble booting, per message below
> we seemed to start it, but processor didnt run startup code... Suspect its a 
> failing part probably..
> 
> > CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU1: Thermal monitoring enabled
> > CPU1: Intel(R) Xeon(TM) CPU 2.80GHz stepping 09
> > Booting processor 2/6 eip 2000
> > CPU 2 irqstacks, hard=c04b8000 soft=c04b0000
> > Not responding.
> > Inquiring remote APIC #6...
> > ... APIC #6 ID: failed
> > ... APIC #6 VERSION: failed
> > ... APIC #6 SPIV: failed
> > CPU #6 not responding - cannot use it.

Ok i've seen that about 2years ago on a similar Xeon system, it was hard 
to reproduce as it only happened on the occassional boot i was thinking of 
making the processor startup delays longer but could never get it to 
reliably fail. The system is still running today.
