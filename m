Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266832AbUAXBFN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 20:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266834AbUAXBFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 20:05:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29375 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266832AbUAXBFC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 20:05:02 -0500
Message-ID: <4011C4B0.5080803@pobox.com>
Date: Fri, 23 Jan 2004 20:04:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: Arne Ahrend <aahrend@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6: No hot_UN_plugging of PCMCIA network cards
References: <20040122210501.40800ea7.aahrend@web.de> <20040122213757.H23535@flint.arm.linux.org.uk> <20040123232025.4a128ead.aahrend@web.de> <20040124004530.B25466@flint.arm.linux.org.uk>
In-Reply-To: <20040124004530.B25466@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> On Fri, Jan 23, 2004 at 11:20:25PM +0100, Arne Ahrend wrote:
> 
>>>It works for me - with pcnet_cs.  Do you have ipv6 configured into the
>>>kernel?
>>
>>No.
> 
> 
> Argh, it seems that several patches which were in the netdrv experimental
> tree never got merged.
> 
> Jeff - what's the situation with the net driver experimental tree?
> Could the DEV_STALE_CONFIG patches from around December time be
> merged please?


It's slowly being merged into upstream, but it's gonna take time.  This 
stuff (along with pent-up stuff from other maintainers) has to be spread 
out over a few releases.

I'll dig out the csets you're referring to and make sure they're in the 
next batch, post 2.6.2 release.

	Jeff



