Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263645AbUCYWxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263670AbUCYWxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:53:48 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:13784 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S263645AbUCYWw6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:52:58 -0500
Message-ID: <40636295.7000008@pacbell.net>
Date: Thu, 25 Mar 2004 14:52:05 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Robert Schwebel <robert@schwebel.de>
CC: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] RNDIS Gadget Driver
References: <20040325221145.GJ10711@pengutronix.de>
In-Reply-To: <20040325221145.GJ10711@pengutronix.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Schwebel wrote:
> David, 
> 
> finally, here is our RNDIS USB Gadget Driver - see the attached patch
> against the gadget-2.4 BK tree as of now. It shouldn't be too difficult
> to port this to 2.6. 

Yowsza!  I've been looking forward to this ... :)

I'll look it over and see how the 2.6 merge goes, and probably run
some revisions by you.  The autoconfiguration updates will make this
more complicated, since g_ether is starting to support a more dynamic
configuration model; the HH.org crew need that, so PDA Linux distros
don't need to hard-wire as much knowledge about hardware targets
into their kernels.


> The patch adds support for Microsoft's RNDIS protocol to the standard
> g_ether driver. This makes it possible to connect a Linux USB gadget to
> any standard Windows machine and <*PALIM!*> there is a new USB network
> interface on the Windows side on which you can speak TCP/IP :-) 

Which is exactly what a lot of Linux solution providers need to see;
I'm sure this will get a lot of use.  Applause!

(Although I personally would prefer that Microsoft adopt vendor-neutral
protocols, instead of pushing the rest of the industry to adopt things
that are MSFT-biased ... for some reason, they haven't listened to almost
anyone on such topics.  Oh well.  ;)


> Unfortunately, although it works with the original Microsoft driver, you
> need an inf file on the windows side; you can download the template for
> that directly from M$. 
> 
> Thanks to Auerswald GmbH for sponsoring this work!

I'll add them to the official "thank you" list on the
http://www.linux-usb.org/gadget webpage.

- Dave


> Robert
> 
> 



