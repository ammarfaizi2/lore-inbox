Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754934AbWKLDSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934AbWKLDSA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 22:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754933AbWKLDSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 22:18:00 -0500
Received: from terminus.zytor.com ([192.83.249.54]:908 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1753971AbWKLDR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 22:17:59 -0500
Message-ID: <455691CD.9080707@zytor.com>
Date: Sat, 11 Nov 2006 19:15:25 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>, jamey.hicks@hp.com,
       Kevin Hilman <khilman@mvista.com>, Nicolas Pitre <nico@cam.org>,
       Russell King <rmk@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Subject: Re: [patch/rfc 2.6.19-rc5] arch-neutral GPIO calls
References: <200611111541.34699.david-b@pacbell.net> <45567868.8020405@zytor.com> <200611111904.36817.david-b@pacbell.net>
In-Reply-To: <200611111904.36817.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
> I suspect that userspace GPIO accessors should only be written once
> though, and they're going to be in the "don't care" category.  So
> lack of such a "message compatible" GPIO call set might reasonably
> hold up merging that sort of (configfs?) interface.
> 

Yes, the userspace interface is by far the biggest issue here.

	-hpa
