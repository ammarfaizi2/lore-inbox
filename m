Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129460AbRCWECW>; Thu, 22 Mar 2001 23:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129464AbRCWECM>; Thu, 22 Mar 2001 23:02:12 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:39083 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S129460AbRCWECA>;
	Thu, 22 Mar 2001 23:02:00 -0500
Date: Fri, 23 Mar 2001 15:00:59 +1100 (EST)
Message-Id: <200103230400.f2N40xk15331@pcug.org.au>
From: sfr@canb.auug.org.au
To: alan@lxorguk.ukuu.org.uk, twoller@crystal.cirrus.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incorrect mdelay() results on Power Managed Machines x86
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Boot with the 'notsc' option is one approach. We certainly could recalibrate
> the clock if we could get events out of ACPI, APM or some other source. Maybe
> someone at IBM knows something on the thinkpad front here. If there is for
> example an additional apm event or irq we can enable for the thinkpads to see
> the speed change we can make it work

On the ThinkPad 600E (at least), we get a Power Status Change APM event.

Cheers,
Stephen Rothwell

P.S. We actually get two of these events each time we remove or insert the
power cord ...
