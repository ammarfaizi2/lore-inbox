Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267479AbSLEVSm>; Thu, 5 Dec 2002 16:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbSLEVRW>; Thu, 5 Dec 2002 16:17:22 -0500
Received: from opengfs.tovarcom.com ([65.67.58.21]:44200 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S267476AbSLEVRP>; Thu, 5 Dec 2002 16:17:15 -0500
Message-ID: <20021205212631.7585.qmail@escalade.vistahp.com>
References: <3DEFBEB7.9080500@markerman.com>
In-Reply-To: <3DEFBEB7.9080500@markerman.com>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: Byron Albert <byron@markerman.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: host buss on p4 xeon
Date: Thu, 05 Dec 2002 15:26:31 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All the P4 family of processors uses a techniwue called quad pumping or 
something along those lines. So you actually have a 100 Mhz bus, but it can 
take action at 4 different points during the clock cycle hence Marketeering 
gives us 400Mhz bus. It is the same with AMD using the DDR bus/memory. They 
don't actually have a 266/333Mhz, bus it is really a 133/166 bus that is 
double pumped. Hope this helps. 

 --Brian Jackson 

Byron Albert writes: 

> Hello, 
> 
> I am testing some new dual 2.4/2.8ghz Xeon DP boxes. They all have the 
> ServerWorks GC -LE Chipset. I was looking at the dmesg out put and it says 
> that the host buss is 100mhz but I in all the docs about the mother board 
> it says it should 400. Is this some other number or is there some patches 
> I need to get the faster bus speeds? 
> 
> Thanks
> Byron 
> 
> ..... CPU clock speed is 2394.9664 MHz.
> ..... host bus clock speed is 99.7902 MHz.
<snip>
