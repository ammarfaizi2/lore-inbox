Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946274AbWKJKVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946274AbWKJKVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946295AbWKJKVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:21:06 -0500
Received: from www.osadl.org ([213.239.205.134]:22409 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1946274AbWKJKVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:21:05 -0500
Subject: Re: [patch 11/19] i386: Rework local APIC calibration
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1163153841.3138.653.camel@laptopd505.fenrus.org>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233035.340517000@cruncher.tec.linutronix.de>
	 <1163153841.3138.653.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 11:23:23 +0100
Message-Id: <1163154204.8335.199.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 11:17 +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-09 at 23:38 +0000, Thomas Gleixner wrote:
> > plain text document attachment (i386-lapic-calibrate-timer.patch)
> > From: Thomas Gleixner <tglx@linutronix.de>
> 
> One question: why do the irq measurement at all if pmtimer is
> available? 

Good point. OTOH this works everywhere.

	tglx

