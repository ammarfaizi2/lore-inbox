Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUC3PZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 10:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUC3PZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 10:25:55 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:44261 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263711AbUC3PZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 10:25:48 -0500
Subject: Re: System clock speed too high - 2.6.3 kernel
From: john stultz <johnstul@us.ibm.com>
To: Praedor Atrebates <praedor@yahoo.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>,
       Len Brown <len.brown@intel.com>
In-Reply-To: <200403261800.32717.praedor@yahoo.com>
References: <200403261430.18629.praedor@yahoo.com>
	 <1080336165.5408.307.camel@cog.beaverton.ibm.com>
	 <200403261800.32717.praedor@yahoo.com>
Content-Type: text/plain
Message-Id: <1080660339.5408.356.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Mar 2004 07:25:39 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-26 at 15:00, Praedor Atrebates wrote:
> On Friday 26 March 2004 04:22 pm, john stultz held forth thus:
> > On Fri, 2004-03-26 at 11:30, Praedor Atrebates wrote:
> > > In doing a web search on system clock speeds being too high, I found
> > > entries describing exactly what I am experiencing in the linux-kernel
> > > list archives, but have not yet found a resolution.
> > >
> > > I have Mandrake 10.0, kernel-2.6.3-7mdk installed, on an IBM Thinkpad
> > > 1412 laptop, celeron 366, 512MB RAM.  I am finding that my system clock
> > > is ticking away at a rate of about 3:1 vs reality, ie, I count ~3 seconds
> [...]
> > Could you please send me dmesg output for this system?
> >
> Attached is the output of dmesg.  

You mentioned that your system is an older laptop, and you're setting
"acpi=on" in your boot arguments. What happens when you omit "acpi=on"?
Do you get a message saying something to the effect of your system being
too old for ACPI? Does everything still work as it ought?

I'm still working on this one. 
See http://bugme.osdl.org/show_bug.cgi?id=2375 for more details.

thanks
-john

