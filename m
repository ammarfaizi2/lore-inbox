Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbSLETZQ>; Thu, 5 Dec 2002 14:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbSLETZQ>; Thu, 5 Dec 2002 14:25:16 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:13075 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267372AbSLETZP>; Thu, 5 Dec 2002 14:25:15 -0500
Date: Thu, 5 Dec 2002 13:32:51 +0100
From: Torben Mathiasen <torben.mathiasen@hp.com>
To: Felix Maibaum <f.maibaum@tu-bs.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 locks up after ide init on tyan s2460
Message-ID: <20021205123251.GM1252@tmathiasen>
References: <200212051655.43554.f.maibaum@tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212051655.43554.f.maibaum@tu-bs.de>
User-Agent: Mutt/1.4i
X-OS: Linux 2.4.20-pre11 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it work if you boot with 'ide=nodma' ?

Also please provide your dmesg output.

Torben

On Thu, Dec 05 2002, Felix Maibaum wrote:
> Hi!
> 
> fine-print first: I am sorry if this is a stupid question, I know you're all 
> very busy, but I have no other explanation for this than a kernel bug, so 
> here it goes:
> 
> I compiled 2.4.20 on my Tyan s2460 with 2 AMD XP1700+,
> and after the ide init of the promise Ultra66 contoller I get the following 
> message:
> 
> blk: queue c032d16c, I/O limit 4095Mb (mask 0xffffffff)
> 
> and the system locks up (no NumLock, no magic sysreq.).
> This happened with the vanilla kernel as well as with the sources from debian.
> To avoid an attachment I put my kernel config up at:
> 
> http://www.tu-bs.de/~y0013531/kernel_config_2.4.20
> 
> other hardware in the system is:
> 512M of main memory, 80G maxtor on hde, 30 and 45G IBM on hdg and hdh, this is 
> the promise ultra66.
> on the onboard controller there is a toshiba DVD, a plextor 12X CD/RW and a 
> Pioneer DVD-R/RW,
> NVIDIA Geforce2pro,
> 3com Boomerang 10/100 Ethernet
> creative SBLive 1024
> 
> Since I don't subscribe to the list for traffic reasons, please cc me or 
> answer directly. If more data is needed I'll be glad to provide it.
> 
> Thanks
> 
> Felix
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
