Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131899AbRCaBgX>; Fri, 30 Mar 2001 20:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131740AbRCaBgN>; Fri, 30 Mar 2001 20:36:13 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:28178 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131986AbRCaBgG>;
	Fri, 30 Mar 2001 20:36:06 -0500
Date: Sat, 31 Mar 2001 03:35:04 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: kapm-idled using 45% CPU (why not 100%?)
Message-ID: <20010331033504.A7022@pcep-jamie.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject says it all.  On my laptop which is running 2.4.0, while the
machine is completely idle "top" reports kapm-idled as usin about 45% of
the CPU.  The remaining 55% is reported as idle time.

When the machine gets a little more active, the CPU time attributed to
kapm-idled decreases while the 55% idle time increases to 85%!

This is not caused be "top": I get the same 45% from "ps -l 3".

I remember when kapmd was reporting 100%.  Is the new behaviour
intentional, and is it saving the maximum power on the laptop?

thanks,
-- Jamie

