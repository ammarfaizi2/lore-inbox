Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261913AbUCLCHB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbUCLCGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:06:46 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:41443 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S261909AbUCLCGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:06:43 -0500
Message-ID: <40511B2E.5020704@stesmi.com>
Date: Fri, 12 Mar 2004 03:06:38 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: psycosonic <psycosonic@rootisg0d.org>
CC: linux-net@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Abysmal network performance since 2.4.25 !!!!!...
References: <004c01c407cf$5fffa270$0700a8c0@darkgod>
In-Reply-To: <004c01c407cf$5fffa270$0700a8c0@darkgod>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

psycosonic wrote:

> Hey.
> 
> I'm having some problems since i updated from kernel 2.4.24 to 2.4.25 .. it
> seems that 2.4.25 has some real performance problems.
> The problem is that i can't get the NIC's to work fine.. i don't know 
> why, i've already used several kernel configurations..
> i've also tried with patch2.4.25pre4 and... nothin' ...even used another 
> switch 10/100mbit.. not even with patch-2.4.26pre2 it goes normal,
> I've compiled the kernel in another computer, with too many different 
> configurations, different hardware.. etc.. and the result is the same.
> Some friends of mine are having the same problem.
> Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now , 
> with 2.4.25 it only goes to 2,2Mb/s MAX speed.  :(

If you're only seeing 12Mbit/s (b=bit, B=byte) already before
then there's something at play here with your network I'm afraid.

Replace the nics and you'll see the problems should go away.

I haven't seen any problems so far with my equipment.

> Computer 1:
> 
> Pentium 3 @ 733Mhz
> Board with SIS Chipset.
> NIC's: SIS900 & Realtek 8139

My laptop has an 8139 and it works fine.

> AMD XP 2600+
> Board ASUS A7V8X-MX Chipset VIA KT400
> NIC's: VIA Rhine

If you don't solve it I'll check with my Rhine.

> Please gimme some answer ASAP.. i'm getting crazy :(

Start by getting it up to 100Mbit on the old kernel and then ask
for more help as 12Mbit/s points to other problems.

// Stefan
