Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSK1QoL>; Thu, 28 Nov 2002 11:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSK1QoL>; Thu, 28 Nov 2002 11:44:11 -0500
Received: from bitmover.com ([192.132.92.2]:56223 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265736AbSK1QoK>;
	Thu, 28 Nov 2002 11:44:10 -0500
Date: Thu, 28 Nov 2002 08:51:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [rmk@arm.linux.org.uk: Re: connectivity to bkbits.net?]
Message-ID: <20021128085128.A4846@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Russell for doing my legwork.

Mea culpa, I never thought to check to see if sgi had turned off pings.
They apparently have (bummer).

Sorry for the noise, 

--lm

----- Forwarded message from Russell King <rmk@arm.linux.org.uk> -----

Date: Thu, 28 Nov 2002 16:41:19 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: connectivity to bkbits.net?

On Thu, Nov 28, 2002 at 08:25:50AM -0800, Larry McVoy wrote:
> We've been having problems getting out to certain parts of the net for the
> last few days, in particular, we can't get to sgi.com which is unusual.
> If you are having problems getting to bkbits.net, let me know.  We have
> a couple of machines at rackspace and I can push repos over there.

I think you're hitting their firewall.  If I traceroute to the same
address, it stops at the same place.  However, telnet sgi.com 80
"GET /" connects and returns data, so it is reachable.

Unfortunately, in this day and age, telnetting to the http port seems to
be a better test of connectivity than traceroute ever was.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

----- End forwarded message -----

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
