Return-Path: <linux-kernel-owner+w=401wt.eu-S1030214AbWL3CP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030214AbWL3CP4 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 21:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWL3CP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 21:15:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42908 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030214AbWL3CPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 21:15:55 -0500
Date: Fri, 29 Dec 2006 21:15:54 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 2.6.20-rc1 4/6] PXA GPIO wrappers
In-reply-to: <200612281247.36869.david-b@pacbell.net>
X-X-Sender: nico@xanadu.home
To: David Brownell <david-b@pacbell.net>
Cc: pHilipp Zabel <philipp.zabel@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Victor <andrew@sanpeople.com>,
       Bill Gatliff <bgat@billgatliff.com>,
       Haavard Skinnemoen <hskinnemoen@atmel.com>,
       Kevin Hilman <khilman@mvista.com>, Russell King <rmk@arm.linux.org.uk>,
       Tony Lindgren <tony@atomide.com>
Message-id: <Pine.LNX.4.64.0612292107580.18171@xanadu.home>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <200611111541.34699.david-b@pacbell.net>
 <Pine.LNX.4.64.0612211457390.18171@xanadu.home>
 <74d0deb30612212253s7d35cf92q80bbebe9d8ae9476@mail.gmail.com>
 <200612281247.36869.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Dec 2006, David Brownell wrote:

> Phillip:  is this the final version, then?  It's missing
> a signed-off-by line, so I can't do anything appropriate.
> 
> Nico, your signoff here would be a Good Thing too if it
> meets your technical review.  (My only comment, ISTR, was
> that gpio_set_value macro should probably test for whether
> the value is a constant too, not just the gpio pin.)

I don't think so.  Expansion of GPIO_bit(x) is pretty simple even if x 
is not constant.  That probably makes it still less costly than a 
function call.


Nicolas
