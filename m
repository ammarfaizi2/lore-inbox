Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUL3Buz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUL3Buz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 20:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbUL3Buy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 20:50:54 -0500
Received: from mail.tmr.com ([216.238.38.203]:48582 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261501AbUL3Bus (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 20:50:48 -0500
Message-ID: <41D3615F.4090205@tmr.com>
Date: Wed, 29 Dec 2004 21:01:03 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Terry Hardie <terryh@orcas.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Asus P4C800-E Deluxe and Intel Pro/1000
References: <200411112003.43598.Gregor.Jasny@epost.de><6.1.1.1.0.20041108074026.01dead50@ptg1.spd.analog.com> <Pine.LNX.4.58.0412262127510.3478@orcas.net>
In-Reply-To: <Pine.LNX.4.58.0412262127510.3478@orcas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terry Hardie wrote:
> Well, this has been plauging me for months, and finally figured it out.
> 
> Any 2.6 kernel on my board, would boot, then give errors (paraphrased,
> sorry) when I tried to bring up the ethernet:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> IRQ #18: Nobody cared!
> 
> And no ethernet conectivity.
> 
> The Fix: Update bios from asus' website. I guess their ACPI was screwed
> up. This is the second time I've had to update this MB to fix
> incompatibilities with Linux. So, watch out with Asus boards on Linux.
> 
> BTW - Linux 2.4's driver worked fine with the old bios. Only 2.6 didn't
> work.

I'm having that problem, although I didn't with 2.6.7. I'll grab the 
latest BIOS, I have the P4P800 installed, and a P4P800-E deluxe in the 
box with CPU and parts to make it work. Just no particular need for 
another system at this instant.

I think it *may* be related to the VIA RAID controller, although I 
haven't had time to do reboots to see, since I'm trying to get the 
*&*^%&^% i810 audio into 4 channel mode at the moment, which I need more 
than 2.6.

Actually, until 2.6 will use the VIA controller I can't run it full time 
anyway.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
