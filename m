Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUAEVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 16:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265920AbUAEVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 16:18:09 -0500
Received: from ext1.srdnet.com ([63.170.161.100]:49064 "EHLO
	lnxext1.srdnet.extra") by vger.kernel.org with ESMTP
	id S265916AbUAEVR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 16:17:57 -0500
Message-ID: <3FF9D47E.6090309@macykids.net>
Date: Mon, 05 Jan 2004 13:17:50 -0800
From: Brian Macy <bmacy@macykids.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6a) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ion Badulescu <ionut@badula.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and Starfire NIC
References: <200401052044.i05Kib6J019930@buggy.badula.org>
In-Reply-To: <200401052044.i05Kib6J019930@buggy.badula.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This happened all 3 times I booted into the 2.6 kernel. If there is 
something you'd like me to try let me know.

Brian Macy


Ion Badulescu wrote:
> Hi Brian,
> 
> On Tue, 30 Dec 2003 08:48:13 -0800, Brian Macy <bmacy@macykids.net> wrote:
> 
>>When switching to 2.6.0 my Starfire NIC fails to function with an 
>>entertaining message:
>>Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02018101.
>>Dec 23 16:36:45 job kernel: eth0: Something Wicked happened! 0x02010001.
> 
> 
> This says that the card's RX ring is empty. That could be because the 
> driver fails to allocate any descriptors, though that's not very likely. 
> Or it might be a bug...
> 
> Does it happen every time you try, or only sometimes?
> 
> 
>>I don't know if this is related but in 2.4 I get PCI bus congestion for 
>>the starfire adapter:
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 80 bytes
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 96 bytes
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 112 bytes
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 128 bytes
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 144 bytes
>>eth0: PCI bus congestion, increasing Tx FIFO threshold to 160 bytes
> 
> 
> Unrelated. These messages only tell you that the latency on your PCI bus 
> is slightly higher than expected, and the driver is compensating for it.
> 
> Ion
> 
