Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753843AbWKMDap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbWKMDap (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 22:30:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbWKMDap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 22:30:45 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:39653 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S1753843AbWKMDao (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 22:30:44 -0500
Message-ID: <4557E6E4.5050307@billgatliff.com>
Date: Sun, 12 Nov 2006 21:30:44 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net>
In-Reply-To: <200611111541.34699.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

David Brownell wrote:

>I know there have been discussions about standardizing GPIOs before,
>but nothing quite "took".  One of the more recent ones was
>
>  http://marc.theaimsgroup.com/?l=linux-kernel&m=110873454720555&w=2
>
>Below, find what I think is a useful proposal, trivially implementable on
>many ARMs (at91, omap, pxa, ep93xx, ixp2000, pnx4008, davinci, more) as well
>as the new AVR32.
>
>Compared to the proposal above, key differences include:
>  
>

Excellent proposal, I think it should be implemented as-is.  I don't 
care that this proposal only works for "real" GPIOs, and doesn't provide 
for a userspace API.

At its worst, this proposal offers an intermediate step towards a 
framework that can do both synchronous/real and asynchronous GPIO 
control.  At its best, provides a starting point for that framework AND 
a much-needed unification in an API that could really use cleaning up 
TODAY.  No downside, in my opinion.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

