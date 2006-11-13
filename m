Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755271AbWKMU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbWKMU3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 15:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755272AbWKMU3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 15:29:08 -0500
Received: from smtp1.mtco.com ([207.179.226.202]:4745 "EHLO smtp1.mtco.com")
	by vger.kernel.org with ESMTP id S1755271AbWKMU3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 15:29:05 -0500
Message-ID: <4558D591.5030203@billgatliff.com>
Date: Mon, 13 Nov 2006 14:29:05 -0600
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
References: <200611111541.34699.david-b@pacbell.net> <200611131121.23944.david-b@pacbell.net> <4558CAE4.1020202@billgatliff.com> <200611131215.39888.david-b@pacbell.net>
In-Reply-To: <200611131215.39888.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:

>
>Part of this is just that NR_IRQs is a global constant, and it's not
>possible to allocate new IRQ banks after a kernel is built.
>

... because irq_desc is an array, and not a list of some kind.

We have a Virtual File System layer, I guess we need a Virtual Interrupt 
System layer too?  :)

/me shudders


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

