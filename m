Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267068AbTBUBvR>; Thu, 20 Feb 2003 20:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267057AbTBUBvR>; Thu, 20 Feb 2003 20:51:17 -0500
Received: from www.netops.co.uk ([195.224.68.226]:31409 "EHLO netops.co.uk")
	by vger.kernel.org with ESMTP id <S267034AbTBUBvQ>;
	Thu, 20 Feb 2003 20:51:16 -0500
Date: Fri, 21 Feb 2003 02:01:14 +0000 (GMT)
From: Steve Parker <steve.parker@netops.co.uk>
X-X-Sender: steve@www.netops.co.uk.
To: linux-kernel@vger.kernel.org
Subject: Alcatel SpeedTouch USB Modem
Message-ID: <Pine.GSO.4.44.0302210151090.22843-100000@www.netops.co.uk.>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see that the Alcatel kernel-level driver for the Alcatel SpeedTouch USB
Modem is now included in the 2.5 kernel.
This seems strange, since there seem to have been (in the past, at least)
a lot of (panic) problems reported with it, and the speedtouch.sf.net (and
complimentary speedtouchconf.sf.net) are fully capable of running this
modem in userspace.
Have these problems been resolved? Is the kernel driver as stable as the
userspace one? Are there demonstrable perfomance benefits in the kernel
driver?

I've certainly been using my modem for well over a year with the userspace
driver (speedtouch.sf.net) with - as at 2.4.18 - an unpatched kernel, and
no troubles whatsoever. Is there any need for the Alcatel code in the
kernel when the n_hdlc and ppp configs already cater for this modem, once
the microcode is loaded?

What is the status of this driver WRT the Alcatel microcode? Last I heard,
the Alcatel microcode was required by both the Alcatel kernel-level and
the speedtouch.sf.net drivers.

Cheers,

Steve.

