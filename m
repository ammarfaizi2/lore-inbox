Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVC0BKR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVC0BKR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 20:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVC0BKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 20:10:17 -0500
Received: from fire.osdl.org ([65.172.181.4]:15276 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261440AbVC0BKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 20:10:10 -0500
Message-ID: <424607EA.50808@osdl.org>
Date: Sat, 26 Mar 2005 17:10:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ARM] Group device drivers together under their own menu
References: <200503261912.j2QJC192031517@hera.kernel.org> <20050326214141.GR21986@parcelfarce.linux.theplanet.co.uk> <20050326225026.D23306@flint.arm.linux.org.uk> <20050327004549.GS21986@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050327004549.GS21986@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> On Sat, Mar 26, 2005 at 10:50:26PM +0000, Russell King wrote:
> 
>>On Sat, Mar 26, 2005 at 09:41:41PM +0000, Matthew Wilcox wrote:
>>
>>>Any reason you can't merge ARM's options into the drivers/*/Kconfig (with
>>>appropriate conditionals) and use drivers/Kconfig?
>>
>>Dunno.  Haven't gotten around to sorting that out yet, and I don't
>>particularly fancy trying to fight any corners over it.
>>
>>I think, a while back, it was thought to be better to keep ARM separate
>>to keep the conditionals out of drivers/Kconfig.
>>
>>If the general concensus has changed, I might eventually sort it out if
>>it causes enough trouble, or people think there's sufficient value to it.
> 
> 
> As the original author of drivers/Kconfig, I think it's a brilliant
> idea that everybody should use ;-)  I haven't heard any dissenting
> opinions yet.  The only complaint I've heard is that net/Kconfig is now
> under device drivers.  I didn't make that change, and I agree it sucks.

This is likely a little OT for this thread, but
I probably made that change (of grouping all networking
options and drivers together).  And I still think that they
should all be grouped together -- whether it's under
device drivers or a top-level Networking section.

The real problem AFAICT is that Networking options
includes some protocols and then Network Device Support
includes some other protocols.  Maybe if there was a Network Protocol
section things could be clearer.  ??

-- 
~Randy
