Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263379AbUJ2PrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbUJ2PrT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263412AbUJ2PpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:45:16 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:19731 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263379AbUJ2PfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 11:35:07 -0400
Message-ID: <41826668.50208@techsource.com>
Date: Fri, 29 Oct 2004 11:48:56 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Daniel Phillips <phillips@istop.com>, Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE:
 Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com> <417D8218.9080700@techsource.com> <200410271423.33380.phillips@istop.com> <Pine.LNX.4.61.0410271459130.4669@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410271459130.4669@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



linux-os wrote:
> On Wed, 27 Oct 2004, Daniel Phillips wrote:
> 
>> On Monday 25 October 2004 18:45, Timothy Miller wrote:
>>
>>> My intention is to include a bit of logic in the FPGA which can be used
>>> to reprogram the prom.  You would then cycle power to get the FPGA to
>>> load the new code.
>>
>>
>> Power cycle the whole machine, or software-reset the card?
>>
>> Regards,
>>
>> Daniel
> 
> 
> The FPGA requires a physical reset-pin toggle to load new
> bits into the gate-array. This could be software-toggled,
> but that would require at least one external gate. This
> is because the power-reset needs to reset the chip before
> its bits are loaded plus some pin, after loading, needs to
> be an output to its reset pin also. Therefore, you need
> the external gate that is always present.


Generally speaking, more chips == bad.  If reprogramming the FPGA were a 
regular event, I'd see the point, but I hope that MOST users would NEVER 
have to reprogram it.

