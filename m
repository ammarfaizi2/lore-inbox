Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266307AbUBDIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUBDIV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 03:21:58 -0500
Received: from fmr04.intel.com ([143.183.121.6]:59617 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S266307AbUBDIV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 03:21:56 -0500
Subject: Re: Flashing keyboard LEDS upon boot.
From: Len Brown <len.brown@intel.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE0023E85DF@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E85DF@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1075882885.13728.2055.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 04 Feb 2004 03:21:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

Curious that the 2nd boot works...

In any case, if the kernel dies in the early ACPI table parsing code
you'd never get any console output -- so Willy may be right.

Let me know if the system boots with "acpi=off", but does not boot
without.

thanks,
-Len

On Tue, 2004-02-03 at 18:13, Willy Tarreau wrote:
> Hi Dick,
> 
> On Mon, Feb 02, 2004 at 11:06:50AM -0500, Richard B. Johnson wrote:
> > > Sometimes, when booting Linux-2.3.24 from bzImage, machines
> >                                   ^
> > Typo                      Linux-2.4.24
> >
> > > display "Uncompressing Linux ..., Ok. Booting the kernel."
> > > Then the machine just sits there with the keyboard LEDS
> > > (Num-Lock, Caps-lock, and Scroll-lock) flashing at about
> > > a 1-second interval. It will do this "forever".
> 
> Flashing leds indicate a kernel panic on recent kernels (was in -ac
> for
> a while).
> 
> > > Can anybody tell me what it has found "wrong" that prevents
> > > it from continuing the boot? A whole bunch of new Dell Computers
> > > display this problem. The second boot will always work, but
> > > the first cold-start boot will often result in this problem.
> 
> Hmmm. perhaps ACPI or a broken driver ?
> 
> Cheers,
> Willy
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

