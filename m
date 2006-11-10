Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946262AbWKJKQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946262AbWKJKQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946270AbWKJKQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:16:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24736 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946262AbWKJKQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:16:29 -0500
Subject: Re: [patch 08/19] i386: cleanup apic code
From: Arjan van de Ven <arjan@infradead.org>
To: tglx@linutronix.de
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>,
       John Stultz <johnstul@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <1163153798.8335.196.camel@localhost.localdomain>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061109233034.987972000@cruncher.tec.linutronix.de>
	 <1163153099.3138.642.camel@laptopd505.fenrus.org>
	 <1163153798.8335.196.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:16:25 +0100
Message-Id: <1163153785.3138.651.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-10 at 11:16 +0100, Thomas Gleixner wrote:
> > > +EXPORT_SYMBOL(switch_APIC_timer_to_ipi);
> > 
> > why is this exported at all? Modules really shouldn't be touching apic
> > level details.... 
> 
> This is exported for ACPI to handle the C3 stops lapic hell.


sounds that's so internal that it truely deserves to be a _GPL export

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

