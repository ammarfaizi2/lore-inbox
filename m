Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262290AbUJZPOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbUJZPOq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 11:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262291AbUJZPOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 11:14:46 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:1803 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S262290AbUJZPOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 11:14:44 -0400
Message-ID: <417E6CF3.503@techsource.com>
Date: Tue, 26 Oct 2004 11:27:47 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Giuseppe Bilotta <bilotta78@hotpop.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Some discussion points open source friendly graphics [was: HARDWARE:
   Open-Source-Friendly Graphics Cards -- Viable?]
References: <417D21C8.30709@techsource.com> <417D6365.3020609@pobox.com> <MPG.1be854649d4829f8989704@news.gmane.org>
In-Reply-To: <MPG.1be854649d4829f8989704@news.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Giuseppe Bilotta wrote:
> Timothy Miller wrote:
> 
>>>The reprogramability of the FPGA has many advantages, but 
>>>reprogramability is not its primary purpose.  The primary reason to use 
>>>an FPGA is to minimize NRE for manufacturing.  However, as a result, 
>>>users will be able to download updates.  Additionally, those who are 
> 
> 
> Jeff Garzik wrote:
> 
>>Will the capability to apply these updates be included with the base card?
>>Will users need to purchase additional "update FPGA" hardware to do the 
>>reprogramming?
> 
> 
> Also, what if the reprogramming goes wrong? Do I just throw the 
> card away or will there be some form of recovery possible?
> 


For those who are taking the risk of reprogramming it completely, 
they'll already have read the schematics and instructions for using an 
external device to program the PROM.

For everyone else, it's the same problem you get when programming a 
motherboard goes awry.  When the BIOS is hosed, you can't use the MB 
until you replace the chip.

For cost reasons, we likely wouldn't socket the chip, so you'd probably 
have to send it in for an RMA.  We'd reprogram it, and send it back.  Or 
if you have a friend with the right tools, they can do it.

