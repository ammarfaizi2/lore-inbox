Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVCAU1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVCAU1i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 15:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbVCAU1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 15:27:38 -0500
Received: from alog0386.analogic.com ([208.224.222.162]:51072 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262050AbVCAU1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 15:27:23 -0500
Date: Tue, 1 Mar 2005 15:26:02 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Ben Greear <greearb@candelatech.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Network speed Linux-2.6.10
In-Reply-To: <4224CE98.2060204@candelatech.com>
Message-ID: <Pine.LNX.4.61.0503011523330.706@chaos.analogic.com>
References: <Pine.LNX.4.61.0503011426180.578@chaos.analogic.com>
 <4224CE98.2060204@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2005, Ben Greear wrote:

> linux-os wrote:
>> 
>> Conditions:
>> 
>> Intel NIC e100 device driver. Two identical machines.
>> Private network, no other devices. Connected using a Netgear switch.
>> Test data is the same thing sent from memory on one machine
>> to a discard server on another, using TCP/IP SOCK_STREAM.
>> 
>> If I set both machines to auto-negotiation OFF and half duplex,
>> I get about 9 to 9.5 megabytes/second across the private wire
>> network.
>> 
>> If I set one machine to full duplex and the other to half-duplex
>> I get 10 to 11 megabytes/second transfer across the network,
>> regardless of direction.
>
> That is asking for all sorts of trouble.
>
>> If I set both machines to auto-negotiation OFF and full duplex,
>> I get 300 to 400 kilobytes/second regardless of the direction.
>
> Check for errors in the NICs counters (/proc/net/dev/) in this case.
> It appears it is not actually set to full-duplex, or maybe it's
> 10Mbps-FD.  Use ethtool to see the actual settings.
>

I supplied the actual settings.

> What happens if you just don't muck with the NIC and let it auto-negotiate
> on it's own?
>

It goes to half-duplex and runs 9 to 9.5 megabytes/second as stated
above.

That's why I think 1/2 duplex is __really__ full-duplex.

> Ben
>
>
> -- 
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
