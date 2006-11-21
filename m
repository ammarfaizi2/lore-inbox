Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030700AbWKUDoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030700AbWKUDoN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 22:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030701AbWKUDoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 22:44:13 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:40372 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1030700AbWKUDoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 22:44:12 -0500
Message-ID: <4562760E.3000906@billgatliff.com>
Date: Mon, 20 Nov 2006 21:44:14 -0600
From: Bill Gatliff <bgat@billgatliff.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20060926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Paul Mundt <lethal@linux-sh.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <4558C794.90602@billgatliff.com> <20061113201535.GA20388@linux-sh.org> <200611201349.29999.david-b@pacbell.net>
In-Reply-To: <200611201349.29999.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>A fine example of two platform-specific notions.  First, that GPIO signals
>are muxed in that way ... they could easily have dedicated pins!!  Second,
>that there's even a one-to-one association between pins and GPIOs ... I'll
>repeat the previous example of OMAP1, where certain GPIOs could come out on
>any of several pins.  And where some pins can be muxed to work with more
>than one GPIO (but only one at a time, of course).  Clearly, neither pin
>refcounting nor GPIO claiming can be sufficient to prevent such problems ...
>  
>

So, you're saying that if GPIOA1 can come out on pins ZZ1 and BB6, then 
there would be two unique "GPIO numbers", one for each possibility?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

