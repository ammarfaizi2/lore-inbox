Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbWKVErR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbWKVErR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 23:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030869AbWKVErR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 23:47:17 -0500
Received: from smtp2.mtco.com ([207.179.226.205]:8628 "EHLO smtp2.mtco.com")
	by vger.kernel.org with ESMTP id S1030609AbWKVErR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 23:47:17 -0500
Message-ID: <4563D651.50109@billgatliff.com>
Date: Tue, 21 Nov 2006 22:47:13 -0600
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
Subject: Re: [Bulk] Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <200611211013.19127.david-b@pacbell.net> <4563C5B1.2040304@billgatliff.com> <200611212045.24581.david-b@pacbell.net>
In-Reply-To: <200611212045.24581.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David:

David Brownell wrote:

>On Tuesday 21 November 2006 7:36 pm, Bill Gatliff wrote:
>
>  
>
>>I don't need to REmux, but I don't want to bother setting up the routing 
>>manually at all.  I think the GPIO management stuff can do it properly 
>>on my behalf, given the information we have to acquire to get the GPIO 
>>API to work in the first place.
>>    
>>
>
>Yet requesting GPIO_62 still doesn't tell me I have to
>update muxing for ball M7 or G20
>

Which is why I was pushing you to define a GPIO62M7 enumeration!

> ... and knowing that for
>GPIOs doesn't go anywhere near knowing that for all the
>other chip functions.
>  
>

True, but we've got to start somewhere!  :)


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com

