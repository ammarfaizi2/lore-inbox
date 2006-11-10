Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946384AbWKJK4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946384AbWKJK4O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946388AbWKJK4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:56:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:17051 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946384AbWKJK4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:56:13 -0500
Subject: Re: [patch 13/19] GTOD: Mark TSC unusable for highres timers
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
       Roman Zippel <zippel@linux-m68k.org>
In-Reply-To: <200611101147.26081.ak@suse.de>
References: <20061109233030.915859000@cruncher.tec.linutronix.de>
	 <20061110011336.008840cf.akpm@osdl.org>
	 <1163154958.3138.671.camel@laptopd505.fenrus.org>
	 <200611101147.26081.ak@suse.de>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 10 Nov 2006 11:55:58 +0100
Message-Id: <1163156158.3138.677.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Do we? Where?  AFAIK we just do some resetting after cpu frequency
> changes, but on C3 TSC is just disabled globally.
> 
> That is better than it sounds.

is it?
> 
> Most systems don't have C3 right now. And on those that have
> (laptops) it tends to be not that critical because they normally
> don't run workload where gettimeofday() is really time critical
> (and nobody expects them to be particularly fast anyways)

and that got changed when the blade people decided to start using laptop
processors ......

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

