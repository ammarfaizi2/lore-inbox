Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315449AbSHBQG6>; Fri, 2 Aug 2002 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSHBQG6>; Fri, 2 Aug 2002 12:06:58 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:53732 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315456AbSHBQGD>; Fri, 2 Aug 2002 12:06:03 -0400
Message-ID: <3D4AAFCB.7090700@snapgear.com>
Date: Sat, 03 Aug 2002 02:14:03 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Matthew Wilcox <willy@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.30uc0 MMU-less patches
References: <20020802145034.B24631@parcelfarce.linux.theplanet.co.uk> <3D4AAA87.8050508@snapgear.com> <20020802170007.E11451@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell,

Russell King wrote:
> On Sat, Aug 03, 2002 at 01:51:35AM +1000, gerg wrote:
> 
>>Matthew Wilcox wrote:
>>
>>> - the Makefile changes seem terribly inappropriate.
>>
>>Some simplify cross compilation (like the ARCH and CROSS_COMPILE changes).
> 
> 
> make ARCH=foo CROSS_COMPILE=arm-linux-
> 
> variables on makes command line override variables in the makefile.

That should help clean up that Makefile patch a bit :-)


>>> - drivers/char/mcfserial.c needs to be converted to the new serial core
>>>   and moved to drivers/serial.
>>> - ditto arch/m68knommu/platform/68360/quicc/uart.c
>>
>>Yep, I am looking at that now. That will take me a little
>>effort and time to put together.
> 
> 
> You should be aware that I'm going to be submitting a minor change in
> the interface (as detailed in Documentation/serial/driver) soon, mainly
> to make Dave Miller happy.  Patch soon to be available.

OK, I'll keep an eye out for that.

Thanks
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.snapgear.com

