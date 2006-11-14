Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966364AbWKNVSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966364AbWKNVSk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 16:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965997AbWKNVSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 16:18:40 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:35758 "EHLO
	rhlx01.hs-esslingen.de") by vger.kernel.org with ESMTP
	id S966364AbWKNVSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 16:18:39 -0500
Date: Tue, 14 Nov 2006 22:18:37 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: Re: CONFIG_NO_HZ: missed ticks, stall (keyb IRQ required) [2.6.18-rc4-mm1]
Message-ID: <20061114211837.GC15440@rhlx01.hs-esslingen.de>
References: <EB12A50964762B4D8111D55B764A8454E0DC9D@scsmsx413.amr.corp.intel.com> <20061114203016.GA15440@rhlx01.hs-esslingen.de> <20061114210049.GB15440@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114210049.GB15440@rhlx01.hs-esslingen.de>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Nov 14, 2006 at 10:00:49PM +0100, Andreas Mohr wrote:
> OK, offset 0x8C Host Bus Power Management Control has

Ick, make the actual sub register 0x8D.  Sorry for the noise.
And yes, VT8235 and VT8237 seem identical in this byte.

Andreas Mohr
