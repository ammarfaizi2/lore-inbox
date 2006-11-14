Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965873AbWKNRa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965873AbWKNRa4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbWKNRa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:30:56 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:10169 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S1755450AbWKNRaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:30:55 -0500
Date: Tue, 14 Nov 2006 18:30:54 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061114173054.GA27092@rhlx01.hs-esslingen.de>
References: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EB12A50964762B4D8111D55B764A8454E0DBDE@scsmsx413.amr.corp.intel.com>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 14, 2006 at 09:21:02AM -0800, Pallipadi, Venkatesh wrote:
> >I belive that Venki has looked at some of the HPET enumeration issues,
> >and maybe he has some suggestions.  Is there an example system
> >on-hand where we know Windows works and Linux does not?
> >
> 
> There are two things that can be happening when OS does not see HPET in
> ACPI.
> - BIOS did enable HPET in chipset and did not communicate it to OS.
> - BIOS did nothing to enable HPET in chipset.

I'm sure you've already seen
http://semthex.freeflux.net/blog/archive/2006/10/21/hpet-to-be-or-not-to-be.html
... or not?

Hmm, hopefully it's easy to research where to enable HPET
(if there is one at all!) on an el-cheapo VIA chipset...

Many thanks for your patch! (even though currently Intel-only)

Andreas Mohr
