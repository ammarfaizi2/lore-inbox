Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263379AbRFAE5o>; Fri, 1 Jun 2001 00:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263381AbRFAE5Y>; Fri, 1 Jun 2001 00:57:24 -0400
Received: from f75.law3.hotmail.com ([209.185.241.75]:25864 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S263379AbRFAE5V>;
	Fri, 1 Jun 2001 00:57:21 -0400
X-Originating-IP: [65.25.173.87]
From: "John William" <jw2357@hotmail.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Abysmal RECV network performance
Date: Fri, 01 Jun 2001 04:57:14 
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F75GMVJ7AnvcesML51O000040fe@hotmail.com>
X-OriginalArrivalTime: 01 Jun 2001 04:57:15.0037 (UTC) FILETIME=[5380ACD0:01C0EA57]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Depends on what is driving it...  An application I built can only push 
>about
>80 Mbps bi-directional on PII 550Mhz machines.  It is not the most 
>efficient program in
>the world, but it isn't too bad either...
>
>I missed the rest of this thread, so maybe you already mentioned it, but
>what is the bottleneck?  Is your CPU running at 100%?
>
>Greatly increasing the buffers both in the drivers and in the sockets
>does wonders for higher-speed connections, btw.
>
>Ben

I don't know what the bottleneck is. What I'm seeing is ~60Mbps transmit 
speed and anywhere from 1 to 12Mpbs receive speed on a couple 10/100 cards 
using the 2.2.16, 2.2.19 and 2.4.3 kernels.

I have tried increasing the size of the RX ring buffer and it did not seem 
to make any difference. It appears that there is some sort of overrun or 
other problem. There is a significant slowdown between the 2.2.x and 2.4.x 
kernels.

However, just tonight, while really hammering on the system, I started to 
get some messages like "eth1: Oversized Ethernet frame spanned multiple 
buffers, status 7fff8301!". Any ideas what could be causing that?

- John

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

