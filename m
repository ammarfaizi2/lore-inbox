Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUCEWpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 17:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUCEWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 17:45:51 -0500
Received: from mail001.syd.optusnet.com.au ([211.29.132.142]:52671 "EHLO
	mail001.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261397AbUCEWpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 17:45:49 -0500
From: Stuart Young <sgy-lkml@amc.com.au>
Organization: AMC Enterprises P/L
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Subject: Re: ACPI battery info failure after some period of time, 2.6.3-x and up
Date: Sat, 6 Mar 2004 09:45:49 +1100
User-Agent: KMail/1.5.4
Cc: David Ford <david+challenge-response@blue-labs.org>, jason@stdbev.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <4047756D.2050402@blue-labs.org> <200403051543.04300.sgy-lkml@amc.com.au> <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0403051259480.387@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403060944.27053.sgy-lkml@amc.com.au>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004 04:02 pm, Jeff Chua wrote:
> On Fri, 5 Mar 2004, Stuart Young wrote:
> > ...and it just failed then, using 2.6.4-rc2 still.
>
> have you tried applying patch from ...
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.
>4/ acpi-20040220-2.6.4.diff.bz2
>
>
> I'm on IBM X30, linux 2.6.4-rc2. No problem.
>
>
> # uptime
>  13:02:07 up  3:31,  4 users,  load average: 0.08, 0.07, 0.08
>
> # cat /proc/acpi/battery/BAT0/state
> present:                 yes
> capacity state:          ok
> charging state:          unknown
> present rate:            0 mW
> remaining capacity:      31780 mWh
> present voltage:         12419 mV

Same failure. Works for 15-20 mins, then it stops reporting anything past the 
battery being present.

--
 Stuart Young - sgy-lkml@amc.com.au is for LKML and related email only

