Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264624AbRGDM6S>; Wed, 4 Jul 2001 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264660AbRGDM6I>; Wed, 4 Jul 2001 08:58:08 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:61714 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S264624AbRGDM5z>;
	Wed, 4 Jul 2001 08:57:55 -0400
Date: Wed, 4 Jul 2001 14:57:52 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Juergen Wolf <JuWo@N-Club.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
Message-ID: <20010704145752.A29311@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com> <3B42DEC2.AAB1E65B@N-Club.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B42DEC2.AAB1E65B@N-Club.de>; from JuWo@N-Club.de on Wed, Jul 04, 2001 at 11:15:46AM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Wolf <JuWo@N-Club.de> ecrit :
[...]
Jul  2 13:06:59 localhost kernel: eth0: Too much work at interrupt, IntrStatus=0x008d0004.

Receive Status Valid
Receive Copy In Progress
Transmit Idle
Receive Queue Empty -> no more receive buffer available

It looks like one waits too long before processing incoming data
but I'm curious to know where they come from if nothing is plugged.

[...]
>   Bus  1, device   0, function  0:
>     VGA compatible controller: nVidia Corporation NV11 (rev 161).
>       IRQ 10.
>       Master Capable.  Latency=32.  Min Gnt=5.Max Lat=1.
>       Non-prefetchable 32 bit memory at 0xdc000000 [0xdcffffff].
>       Prefetchable 32 bit memory at 0xd0000000 [0xd7ffffff].

Is X or something like a nvidia module enabled ?

-- 
Ueimor
